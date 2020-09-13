import 'dart:async';

import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:ecoupon_lib/models/currency.dart';
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:injectable/injectable.dart';

import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/screens/wallet/transactions_list.dart';

import 'package:ecoupon_lib/models/wallet.dart';
import 'package:rxdart/subjects.dart';

@lazySingleton
class WalletViewModel extends BaseViewModel {
  final IRouter _router;
  final IWalletRepo _walletRepo;
  final IWalletService _walletService;
  final INetworkInfo _networkInfo;

  ViewState _walletState = Initial();
  ViewState _amountState = Initial();
  ViewState _transactionState = Initial();

  WalletEntity _wallet;
  ListCursor _transactionListCursor;

  PublishSubject<List<Transaction>> _transactionStreamController =
      PublishSubject();

  WalletViewModel(
      this._router, this._walletService, this._networkInfo, this._walletRepo);

  ViewState get walletState => this._walletState;
  ViewState get amountState => this._amountState;
  ViewState get transactionState => this._transactionState;
  // TODO instead of showing an empty wallet open create wallet again
  WalletEntity get wallet => this._wallet == null
      ? WalletEntity(Wallet(
          '',
          '',
          Currency('', '', '', 0, 0, null, null, false, null, null),
          null,
          0,
          null))
      : this._wallet;

  Future<bool> get isConnected => _networkInfo.isConnected;

  Future<void> init() async {
    _walletState = Loading();
    setViewState(Update());

    _walletService.walletStream.listen((event) {
      if (event != null) {
        _wallet = event;
        loadTransactions();
        setViewState(Update());
      }
    });

    _wallet = _walletService.getSelected();

    _walletState = Loaded();
    setViewState(Update());

    try {
      await updateWallet();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateWallet() async {
    _amountState = Loading();
    _transactionState = Loading();
    setViewState(Update());

    var walletOrFailure = await _walletService.fetchAndUpdateSelected();
    walletOrFailure.fold((failure) => setViewState(Error(failure)), (success) {
      _wallet = success;
      _amountState = Loaded();
    });

    await loadTransactions();

    setViewState(Update());
  }

  Stream<List<TransactionListEntry>> get transactionStream =>
      _transactionStreamController.stream.transform(StreamTransformer<
              List<Transaction>, List<TransactionListEntry>>.fromHandlers(
          handleData: (data, sink) async {
        if (data.isNotEmpty) {
          var list = <TransactionListEntry>[];
          data.sort((a, b) => a.created.compareTo(b.created));
          data.reversed
              .fold(Map<DateTime, List<Transaction>>(),
                  (Map<DateTime, List<Transaction>> a, b) {
                var dateOnly =
                    DateTime(b.created.year, b.created.month, b.created.day);
                a.putIfAbsent(dateOnly, () => []).add(b);
                return a;
              })
              .values
              .where((element) => element.isNotEmpty)
              .map((e) {
                list.add(TransactionListHeaderEntry(e.first.created));

                list.addAll(e
                    .map((t) => TransactionListItemEntry(
                        date: t.created,
                        text: t.to,
                        amount: t.amount,
                        isNegative: _wallet.id == t.from))
                    .toList());
              })
              .toList();
          sink.add(list);
        } else {
          sink.add([]);
        }
      }));

  //
  Future<void> loadTransactions() async {
    await _loadTransactions(null);
  }

  Future<void> loadMore() async {
    // how to check if there is more to load?
    await _loadTransactions(_transactionListCursor);
  }

  Future<void> _loadTransactions(ListCursor cursor) async {
    var transactionsOrFailure =
        await _walletService.fetchAndUpdateSelectedTransactions(cursor);

    transactionsOrFailure.fold((failure) {
      setViewState(Error(failure));
    }, (transactionResponse) {
      _transactionListCursor = transactionResponse.cursor;
      _transactionStreamController.add(transactionResponse.items);
    });
    _transactionState = Loaded();
  }
  //

  //
  void makePayment() async {
    await _router.pushNamed(QRScanRoute);
  }

  //
  void makePaymentRequest() async {
    await _router.pushNamed(RequestPaymentRoute);
  }

  //
  void onClaim() async {
    var profileOrFailure =
        await _walletRepo.profiles(false, forWalletId: _wallet.id);

    await profileOrFailure.fold((failure) {
      setViewState(Error(failure));
    }, (profiles) async {
      if (profiles != null) {
        var pendingProfiles = profiles
            .where((element) =>
                element.verificationStage == VerificationStage.pendingPIN)
            .toList();

        if (pendingProfiles.length > 1) {
          setViewState(Error(MessageFailure(
              'Die Pin Verifizierung von mehr als einem Profil ist noch offen. Bitte melde dich bei der Gemeinde.')));
          return;
        }

        if (pendingProfiles.isEmpty) {
          await _router.pushNamed(VerificationRoute, arguments: wallet.id);
          return;
        }

        await _router.pushNamed(VerifyPinRoute);
      } else {
        setViewState(Error(UnknownFailure()));
      }
    });
  }

  //
  void onRedeem() async {
    var profileOrFailure =
        await _walletRepo.companyProfiles(walletId: _wallet.id);

    await profileOrFailure.fold((failure) {
      setViewState(Error(failure));
    }, (profiles) async {
      if (profiles != null && profiles.isNotEmpty) {
        var profile = profiles[0];

        switch (profile.verificationStage) {
          case VerificationStage.maxClaimsReached:
            setViewState(Error(MessageFailure('Maximale Anzahl erreicht.')));
            break;
          case VerificationStage.verified:
            await _router.pushNamed(RedeemRoute);
            break;
          case VerificationStage.pendingPIN:
            await _router.pushNamed(VerifyPinRoute);
            break;
          // TODO verification stage : no verification possible ?
          case VerificationStage.notMatched:
            await _router.pushNamed(VerificationRoute);
            break;
        }
      } else {
        await _router.pushNamed(VerificationRoute);
      }
    });
  }
}
