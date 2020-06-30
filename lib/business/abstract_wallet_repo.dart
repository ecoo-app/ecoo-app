import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:e_coupon/data/wallet_repo.dart';
import 'package:e_coupon/injection.dart';
import 'package:injectable/injectable.dart';

import 'entities/wallet.dart';

abstract class IWalletRepo {
  Future<Either<Failure, List<Wallet>>> getWallets(userIdentifier);
  Future<Either<Failure, Wallet>> getWalletData(id);
  Future<Either<Failure, List<Transaction>>> getWalletTransactions(
      id, filter); // and pagination cursor?
}
