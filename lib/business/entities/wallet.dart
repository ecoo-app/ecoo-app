import 'package:e_coupon/business/entities/currency.dart';
import 'package:equatable/equatable.dart';
import 'package:ecoupon_lib/models/wallet.dart' as lib;

class WalletEntity extends Equatable {
  final lib.Wallet _wallet;

  WalletEntity(this._wallet);

  @override
  List<Object> get props => [_wallet];

  String get id => this._wallet.walletID;
  String get amountLabel => (this._wallet.balance / 100).toStringAsFixed(2);
  int get amount => this._wallet.balance;
  Currency get currency => Currency(this._wallet.currency);
  bool get isShop => this._wallet.isCompanyWallet;

  String toAmountCurrencyLabel() => '${_wallet.currency.name} $amountLabel';

  static WalletEntity createReciever(String reciverId, String reciverKey) {
    return WalletEntity(
        lib.Wallet(reciverId, reciverKey, null, null, null, null));
  }
}
