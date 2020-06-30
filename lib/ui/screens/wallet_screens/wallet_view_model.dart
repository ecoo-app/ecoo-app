import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/get_wallet.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:e_coupon/ui/core/base_view_model.dart';
import 'package:flutter/cupertino.dart';

// add AppStateModel -> holds all wallets and the current selected... ?

class WalletViewModel extends BaseViewModel {
  String _walletId =
      'BA8ED1'; // TODO get wallet from shared Preferences (always save last used wallet and use it on app open)
  Wallet _walletData;
  List<Transaction> _walletTransactions;
  final GetWallet getWallet;

  WalletViewModel({this.getWallet});

  String get selectedWalletId => _walletId;
  Wallet get selectedWallet => _walletData;
  List<Transaction> get selectedWalletTransactions => _walletTransactions;

  void setSelectedWalletId(String walletId) {
    _walletId = walletId;
    //Future<Either<Failure, Wallet>> wallet = GetWallet();
    getWallet(Params(id: _walletId)).then((resp) {
      resp.fold((failure) {
        print('failure');
      }, (wallet) {
        print('yay');
      });
    });
  }
}
