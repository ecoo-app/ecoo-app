import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:ecoupon_lib/models/wallet.dart';
import 'package:equatable/equatable.dart';
import 'package:ecoupon_lib/models/wallet.dart' as lib;

class WalletEntity extends Equatable {
  final lib.Wallet _wallet;

  WalletEntity(this._wallet);

  @override
  List<Object> get props => [_wallet];

  String get id => this._wallet.walletID;
  String get amountLabel => Utils.moneyToString(this._wallet.balance);
  int get amount => this._wallet.balance;
  Currency get currency => Currency(this._wallet.currency);
  bool get isShop => this._wallet.category == WalletCategoy.company;

  Wallet get walletModel => this._wallet;

  String toAmountCurrencyLabel() => '${_wallet.currency.symbol} $amountLabel';

// TODO deprecated
  static WalletEntity createReciever(String reciverId, String reciverKey) {
    return WalletEntity(
        lib.Wallet(reciverId, reciverKey, null, null, null, null));
  }
}
