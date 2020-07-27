import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/wallet.dart';

class Empty {}

class Transfer {
  Either<Empty, WalletEntity> sender;
  Either<Empty, WalletEntity> reciever;
  Either<Empty, int> amount;

  Transfer({this.sender, this.reciever, this.amount});
}
