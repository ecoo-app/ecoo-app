import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/core/failure.dart';

import 'entities/wallet.dart';

abstract class IWalletRepo {
  List<Wallet> getWallets();
  Future<Either<Failure, Wallet>> getWalletData(id);
  Future<Either<Failure, List<Transaction>>> getWalletTransactions(
      id, filter); // and pagination cursor?
}
