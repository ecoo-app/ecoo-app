import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/use_cases/get_transactions.dart';
import 'package:e_coupon/business/use_cases/get_wallet.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:meta/meta.dart';

import 'package:e_coupon/ui/core/widgets/transactions_list.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WalletViewModel extends BaseViewModel {
  WalletState _walletState;
  final GetWallet getWallet;
  final GetTransactions getTransactions;

  WalletViewModel({this.getWallet, this.getTransactions})
      : this._walletState = WalletState(WalletData(walletID: null));

  WalletState get walletState => this._walletState;

  Future<void> setWalletId(String walletId) async {
    if (walletId != null && walletId == _walletState.value.walletID) {
      await updateWalletDetail();
    } else {
      _walletState = WalletState(WalletData(walletID: walletId));
      await loadWalletDetail();
      await updateWalletDetail();
    }
  }

  //
  //
  Future<void> loadWalletDetail() async {
    _walletState.processingState = Loading();
    if (_walletState.value.amount == null)
      _walletState.value.amount = AmountState(0);
    _walletState.value.amount.processingState = Loading();
    if (_walletState.value.transactions == null)
      _walletState.value.transactions = TransactionsState([]);
    _walletState.value.transactions.processingState = Loading();
    setState(ViewStateEnum.Busy);

    if (_walletState.value.walletID == null) {
      // TODO: handle in repository: if id == null get other data (from shared prefs) then if id != null
      _walletState.value.walletID = 'DR345GH67';
    }

    var walletOrFailure =
        await getWallet(WalletParams(id: _walletState.value.walletID));
    walletOrFailure.fold((failure) => print('FAILURE'), (wallet) {
      _walletState.value.currency = wallet.currency;
      _walletState.value.isShop = wallet.isShop;
      _walletState.value.amount.value = wallet.amount;
    });

    _walletState.processingState = Loaded();
    _walletState.value.amount.processingState = Loaded();
    setState(ViewStateEnum.Idle);
  }

  //
  //
  Future<void> updateWalletDetail() async {
    _walletState.value.amount.processingState = Loading();
    setState(ViewStateEnum.Busy);

    if (_walletState.value.walletID == null) {
      // TODO: handle in repository: if id == null get other data (from shared prefs) then if id != null
      _walletState.value.walletID = 'DR345GH67';
    }

    var walletOrFailure =
        await getWallet(WalletParams(id: _walletState.value.walletID));
    walletOrFailure.fold((failure) => print('FAILURE'), (wallet) {
      _walletState.value.currency = wallet.currency;
      _walletState.value.isShop = wallet.isShop;
    });

    _walletState.value.amount.processingState = Loaded();

    await loadTransactions();
  }

  //
  //
  Future<void> loadTransactions() async {
    _walletState.value.transactions.processingState = Loading();

    var transactionsOrFailure = await getTransactions(
        GetTransactionParams(id: _walletState.value.walletID));
    transactionsOrFailure.fold((l) => print('FAILURE'), (transactions) {
      _walletState.value.transactions.value = transactions
          .map((transaction) => TransactionListEntry(transaction))
          .toList();
    });

    _walletState.value.transactions.processingState = Loaded();
    setState(ViewStateEnum.Idle);
  }

  // void loadWalletDetail(String walletId) async {
  //   setViewState(Empty());

  //   if (walletId == null) {
  //     // TODO: handle in repository: if id == null get other data (from shared prefs) then if id != null
  //     walletId = 'DR345GH67';
  //   }
  //   // 2. load wallet from cache or init

  //   setViewState(Loading());

  //   var walletOrFailure = await getWallet(WalletParams(id: walletId));
  //   walletOrFailure.fold(
  //       (failure) => print('FAILURE'), (wallet) => _walletData = wallet);

  //   var transactionsOrFailure =
  //       await getTransactions(GetTransactionParams(id: walletId));
  //   transactionsOrFailure.fold((l) => print('FAILURE'), (transactions) {
  //     _walletTransactions = transactions
  //         .map((transaction) => TransactionListEntry(transaction))
  //         .toList();
  //   });

  //   setViewState(Loaded());
  // }
}

class ValueState<T> {
  T value;
  ViewState processingState = Initial();

  ValueState(T initState) : value = initState;
}

class WalletData {
  String walletID;
  Currency currency = Currency(id: 'loading', label: 'loading');
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

class AmountState extends ValueState<double> {
  AmountState(double initState) : super(initState);
}

class TransactionsState extends ValueState<List<TransactionListEntry>> {
  TransactionsState(List<TransactionListEntry> initState) : super(initState);
}
