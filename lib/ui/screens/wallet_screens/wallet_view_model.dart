import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/use_cases/get_transactions.dart';
import 'package:e_coupon/business/use_cases/get_wallet.dart';
import 'package:e_coupon/ui/core/base_view_model.dart';
import 'package:e_coupon/ui/core/viewstate.dart';
import 'package:e_coupon/ui/shared/transactions_list.dart';
import 'package:injectable/injectable.dart';

// add AppStateModel -> holds all wallets and the current selected... ?

@injectable
class WalletViewModel extends BaseViewModel {
  Wallet _walletData;
  List<TransactionListEntry> _walletTransactions;
  final GetWallet getWallet;
  final GetTransactions getTransactions;

  WalletViewModel({this.getWallet, this.getTransactions});

  Wallet get walletDetail => _walletData;
  List<TransactionListEntry> get walletDetailTransactions =>
      _walletTransactions;

  void loadWalletDetail(String walletId) async {
    setState(ViewState.Busy);

    if (walletId == null) {
      // TODO create use case to get walletId from shared Preferences (always save last used wallet and use it on app open)
      // or should it be handled in the same use case? ? ??
      // BETTER probably: handle in repository: if id == null get other data (from shared prefs) then if id != null
      walletId = 'DR345GH67';
    }

    print('get wallet');
    var walletOrFailure = await getWallet(WalletParams(id: walletId));
    walletOrFailure.fold(
        (failure) => print('FAILURE'), (wallet) => _walletData = wallet);

    var transactionsOrFailure =
        await getTransactions(GetTransactionParams(id: walletId));
    transactionsOrFailure.fold((l) => print('FAILURE'), (transactions) {
      _walletTransactions = transactions
          .map((transaction) =>
              TransactionListEntry(transaction.text, transaction.amount))
          .toList();
    });

    setState(ViewState.Idle);
  }
}
