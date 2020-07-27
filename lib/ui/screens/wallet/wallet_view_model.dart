import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/use_cases/get_transactions.dart';
import 'package:e_coupon/business/use_cases/get_wallet.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:ecoupon_lib/models/currency.dart' as lib;
import 'package:meta/meta.dart';

import 'package:e_coupon/ui/core/widgets/transactions_list.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WalletViewModel extends BaseViewModel {
  WalletState _walletState;
  final GetWallet getWallet;
  final GetTransactions getTransactions;
  final IRouter _router;

  WalletViewModel(this.getWallet, this.getTransactions, this._router)
      : this._walletState = WalletState(WalletData(walletID: null));

  WalletState get walletState => this._walletState;

  //
  Future<void> setWalletId(String walletId) async {
    // TODO improve ifs
    if (_walletState.value.walletID == null) {
      _walletState = WalletState(WalletData(walletID: walletId));
      await loadWalletDetail(walletId);
      await updateWalletDetail(walletId);
    } else if (walletId == null || walletId == _walletState.value.walletID) {
      await updateWalletDetail(walletId);
    } else {
      _walletState = WalletState(WalletData(walletID: walletId));
      await loadWalletDetail(walletId);
      await updateWalletDetail(walletId);
    }
  }
  //

  //
  Future<void> loadWalletDetail(String walletId) async {
    _walletState.processingState = Loading();
    // why do i have to check for null when the constructor sets a wallet with default values?
    if (_walletState.value.amount == null) {
      _walletState.value.amount = AmountState(0);
    }

    _walletState.value.amount.processingState = Loading();

    // why do i have to check for null when the constructor sets a wallet with default values?
    if (_walletState.value.transactions == null) {
      _walletState.value.transactions = TransactionsState([]);
    }

    _walletState.value.transactions.processingState = Loading();
    // TODO how to improve and make a meanigful state change instead of just any replacement to trigger widget update?
    setState(ViewStateEnum.Busy);

    await _getWallet(walletId);

    _walletState.processingState = Loaded();
    _walletState.value.amount.processingState = Loaded();
    setState(ViewStateEnum.Idle);
  }
  //

  //
  Future<void> updateWalletDetail(String walletId) async {
    _walletState.value.amount.processingState = Loading();
    setState(ViewStateEnum.Busy);

    await _getWallet(walletId);

    _walletState.value.amount.processingState = Loaded();

    _walletState.value.transactions.processingState = Loading();
    await loadTransactions();
    _walletState.value.transactions.processingState = Loaded();
    setState(ViewStateEnum.Idle);
  }
  //

  //
  Future<void> _getWallet(String walletId) async {
    if (walletId == null && _walletState.value.walletID == null) {
      // TODO: handle in repository: if id == null get other data (from shared prefs) then if id != null
      _walletState.value.walletID = 'DR345GH67';
    }

    var walletOrFailure =
        await getWallet(WalletParams(id: _walletState.value.walletID));
    walletOrFailure.fold((failure) => print('FAILURE'), (wallet) {
      _walletState.value.wallet = wallet;
      _walletState.value.currency = wallet.currency;
      _walletState.value.isShop = wallet.isShop;
      _walletState.value.amount.value = wallet.amount;
    });
  }
  //

  //
  Future<void> loadTransactions() async {
    var transactionsOrFailure = await getTransactions(
        GetTransactionParams(id: _walletState.value.walletID));
    transactionsOrFailure.fold((l) => print('FAILURE'), (transactions) {
      _walletState.value.transactions.value = transactions
          .map((transaction) => TransactionListEntry(transaction))
          .toList();
    });
  }
  //

  //
  void makePayment() async {
    await _router.pushNamed(TestRoute);
    // await _router.pushNamed(PaymentRoute, arguments: walletState.value.wallet);
  }
}

class ValueState<T> {
  T value;
  ViewState processingState = Initial();

  ValueState(T initState) : value = initState;
}

class WalletData {
  WalletEntity wallet;
  String walletID;
  Currency currency = Currency(lib.Currency('loading', 'loading', 0));
  bool isShop = false;
  AmountState amount = AmountState(0);
  TransactionsState transactions = TransactionsState([]);

  /// if wallet ID is null, wallet ID will be set by shared preferences last wallet id entry
  WalletData(
      {@required this.walletID,
      this.currency,
      this.amount,
      this.isShop,
      this.transactions});
}

class WalletState extends ValueState<WalletData> {
  WalletState(WalletData initState) : super(initState);
}

class AmountState extends ValueState<int> {
  AmountState(int initState) : super(initState);
}

class TransactionsState extends ValueState<List<TransactionListEntry>> {
  TransactionsState(List<TransactionListEntry> initState) : super(initState);
}
