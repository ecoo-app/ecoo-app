import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';

import 'package:e_coupon/ui/core/widgets/transactions_list.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WalletViewModel extends BaseViewModel {
  ViewState _walletState = Initial();
  ViewState _amountState = Initial();
  ViewState _transactionState = Initial();
  WalletEntity _wallet;
  List<TransactionListEntry> _transactions;
  final IRouter _router;
  final IWalletService _walletService;

  WalletViewModel(this._router, this._walletService);

  ViewState get walletState => this._walletState;
  ViewState get amountState => this._amountState;
  ViewState get transactionState => this._transactionState;
  WalletEntity get wallet => this._wallet;
  List<TransactionListEntry> get transactions => this._transactions;

  Future<void> init(WalletEntity wallet) async {
    if (wallet != _wallet) {
      _walletState = Loading();
      setViewState(Update());

      await _walletService.setSelected(wallet);
      _wallet = _walletService.getSelected();

      await loadTransactions();

      _walletState = Loaded();
      setViewState(Update());
    }

    await updateWallet();
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
    var transactionsOrFailure =
        await _walletService.fetchAndUpdateSelectedTransactions();
    transactionsOrFailure.fold((failure) => setViewState(Error(failure)),
        (transactions) {
      _transactionState = Loaded();
      _transactions = transactions
          .map((transaction) => TransactionListEntry(transaction))
          .toList();
    });
  }
  //

  //
  void makePayment() async {
    await _router.pushNamed(TestRoute);
  }

  void makePaymentRequest() async {
    await _router.pushNamed(RequestPaymentRoute);
  }
}
