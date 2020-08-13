import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/ui/core/services/mock_login_service.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:ecoupon_lib/models/currency.dart';
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:injectable/injectable.dart';

import 'package:e_coupon/core/extensions.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/screens/wallet/transactions_list.dart';

import 'package:ecoupon_lib/models/wallet.dart';

@lazySingleton
class WalletViewModel extends BaseViewModel {
  final IRouter _router;
  final IWalletService _walletService;
  final INetworkInfo _networkInfo;

  ViewState _walletState = Initial();
  ViewState _amountState = Initial();
  ViewState _transactionState = Initial();

  WalletEntity _wallet;
  ListCursor _transactionListCursor;
  List<TransactionListEntry> _transactions = [];

  WalletViewModel(
      this._router, this._walletService, this.mockLogin, this._networkInfo);

  ViewState get walletState => this._walletState;
  ViewState get amountState => this._amountState;
  ViewState get transactionState => this._transactionState;
  WalletEntity get wallet => this._wallet == null
      ? WalletEntity(Wallet(
          '',
          '',
          Currency('', '', '', 0, 0, null, null, false, null, null),
          null,
          0,
          null))
      : this._wallet;
  List<TransactionListEntry> get transactions => this._transactions;
  Future<bool> get isConnected => _networkInfo.isConnected;

  Future<void> init(WalletEntity wallet) async {
    if (wallet == null || wallet != _wallet) {
      _walletState = Loading();
      setViewState(Update());

      await _walletService.setSelected(wallet);
      _wallet = _walletService.getSelected();

      if (_wallet != null) {
        await loadTransactions();
      }

      _walletState = Loaded();
      setViewState(Update());
    }

    if (_wallet != null) {
      await updateWallet();
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

  //
  Future<void> loadTransactions() async {
    _transactions = [];
    await _loadTransactions(null);
  }

  Future<void> loadMore() async {
    // how to check if there is more to load?
    await _loadTransactions(_transactionListCursor);
  }

  final MockLoginService mockLogin;
  Future<void> testLogin() async {
    await mockLogin.registerWithGoogle();
  }

  Future<void> _loadTransactions(ListCursor cursor) async {
    var transactionsOrFailure =
        await _walletService.fetchAndUpdateSelectedTransactions(cursor);

    transactionsOrFailure.fold((failure) {
      setViewState(Error(failure));
    }, (transactionResponse) {
      _transactionListCursor = transactionResponse.cursor;

      DateTime lastShownDate;

      transactionResponse.items.forEach((transaction) {
        if (lastShownDate != null &&
            lastShownDate.isSameDate(transaction.created)) {
          _transactions.add(TransactionListEntry(
            date: transaction.created,
            text: transaction.from,
            amount: Utils.moneyToString(transaction.amount),
          ));
        } else {
          _transactions.add(TransactionListEntry(
            date: transaction.created,
            text: transaction.from,
            amount: Utils.moneyToString(transaction.amount),
            showDate: true,
          ));
          lastShownDate = transaction.created;
        }
      });
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
    await _router.pushNamed(VerificationRoute, arguments: wallet.id);
  }

  //
  void onRedeem() async {
    switch (wallet.verificationState) {
      case WalletState.verified:
        await _router.pushNamed(RedeemRoute);
        break;
      case WalletState.pending:
        await _router.pushNamed(VerifyPinRoute);
        break;
      case WalletState.unverified:
        await _router.pushNamed(VerificationRoute);
        break;
    }
  }
}
