import 'dart:collection';

import 'package:e_coupon/business/get_wallets.dart';
import 'package:flutter/cupertino.dart';

// add AppStateModel -> holds all wallets and the current selected... ?

class WalletModel extends ChangeNotifier {
  final walletId = '';

  /// Internal, private state of the cart.
  final List<Wallet> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Wallet> get items => UnmodifiableListView(_items);

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
