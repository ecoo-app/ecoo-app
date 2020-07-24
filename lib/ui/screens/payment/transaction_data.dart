import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';

class TransactionData extends Transaction {
  // in dart constructors do not get inherited, so everything has to be written again.
  TransactionData({WalletEntity sender, WalletEntity reciever, int amount})
      : super(sender: sender, reciever: reciever, amount: amount);
}

class RequestData extends Transaction {
  RequestData({WalletEntity requester, int amount})
      : super(sender: requester, amount: amount);

  WalletEntity get requester => super.sender;
}
