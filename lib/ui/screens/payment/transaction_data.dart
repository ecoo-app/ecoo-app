import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';

class TransactionData extends Transfer {
  TransactionData({WalletEntity sender, WalletEntity reciever, int amount})
      : super(
            sender: Right(sender),
            reciever: Right(reciever),
            amount: Right(amount));
}

class RequestData extends Transfer {
  RequestData({WalletEntity requester, int amount})
      : super(
            sender: Left(Empty()),
            reciever: Right(requester),
            amount: Right(amount));

  WalletEntity get requester => super.sender.fold((l) => null, (r) => null);
}
