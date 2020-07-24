import 'package:e_coupon/business/entities/wallet.dart';

class Transaction {
  WalletEntity sender;
  WalletEntity reciever;
  int amount;

  Transaction({this.sender, this.reciever, this.amount});
}
