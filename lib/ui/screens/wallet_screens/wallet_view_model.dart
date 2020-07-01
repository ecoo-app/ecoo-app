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

    // delay to test
    Future.delayed(const Duration(milliseconds: 500), () async {
      if (walletId == null) {
        // TODO create use case to get walletId from shared Preferences (always save last used wallet and use it on app open)
        // or should it be handled in the same use case? ? ??
        _walletData = Wallet(id: 'BA8ED1');
      } else {
        getWallet(WalletParams(id: walletId)).then((resp) {
          resp.fold((failure) {
            print('failure');
          }, (wallet) {
            _walletData = wallet;
          });
        });

        // TODO put outside if else
        getTransactions(TransactionParams(id: walletId)).then((resp) {
          resp.fold((failure) {
            print('failure');
          }, (transactions) {
            _walletTransactions = transactions
                .map((transaction) =>
                    TransactionListEntry(transaction.text, transaction.amount))
                .toList();
          });
        });
      }

      setState(ViewState.Idle);
    });
  }
}
