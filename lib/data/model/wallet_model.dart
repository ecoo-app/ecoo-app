import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/wallet.dart';

class WalletModel extends Wallet {
  WalletModel(
      {String id, double amount, Currency currency, bool isShop = false})
      : super(id: id, amount: amount, currency: currency, isShop: isShop);
}
