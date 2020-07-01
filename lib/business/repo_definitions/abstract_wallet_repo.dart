import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/core/failure.dart';

abstract class IWalletRepo {
  Future<Either<Failure, List<Wallet>>> getWallets(userIdentifier);
  Future<Either<Failure, Wallet>> getWalletData(id);
  Future<Either<Failure, List<Transaction>>> getWalletTransactions(
      id, filter); // and pagination cursor?
}
