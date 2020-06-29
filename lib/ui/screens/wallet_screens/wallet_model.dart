import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/get_wallet.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:flutter/cupertino.dart';

enum ViewState { Default, Idle, Loading, Success }

// add AppStateModel -> holds all wallets and the current selected... ?

class WalletViewModel extends ChangeNotifier {
  String _walletId =
      'BA8ED1'; // TODO get wallet from shared Preferences (always save last used wallet and use it on app open)
  Wallet _walletData;
  List<Transaction> _walletTransactions;
  final GetWallet getWallet;

  WalletViewModel({this.getWallet});

  final List<Wallet> _items = [];

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

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Wallet item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
