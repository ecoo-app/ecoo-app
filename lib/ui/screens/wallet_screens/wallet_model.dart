import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:flutter/cupertino.dart';

// add AppStateModel -> holds all wallets and the current selected... ?

class WalletModel extends ChangeNotifier {
  String _walletId;
  Wallet _walletData;
  List<Transaction> _walletTransactions;

  /// Internal, private state of the cart.
  final List<Wallet> _items = [];

  String get selectedWalletId => _walletId;
  Wallet get selectedWallet => _walletData;
  List<Transaction> get selectedWalletTransactions => _walletTransactions;

  void setSelectedWalletId(String walletId) {
    _walletId = walletId;
    // TODO
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
