import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/get_wallet.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:e_coupon/ui/core/base_view_model.dart';
import 'package:e_coupon/ui/core/viewstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

// add AppStateModel -> holds all wallets and the current selected... ?

@injectable
class WalletViewModel extends BaseViewModel {
  Wallet _walletData;
  List<Transaction> _walletTransactions;
  final GetWallet getWallet;

  WalletViewModel({this.getWallet});

  Wallet get walletDetail => _walletData;
  List<Transaction> get walletDetailTransactions => _walletTransactions;

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
            print('yay');
            print(wallet);
          });
        });
      }

      setState(ViewState.Idle);
    });
  }
}
