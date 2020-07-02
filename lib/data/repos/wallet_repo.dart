import 'dart:async';

import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/transaction_state.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:injectable/injectable.dart';

import '../../injection.dart';

@Environment(Env.dev)
@LazySingleton(as: IWalletRepo)
class WalletRepo implements IWalletRepo {
  @override
  Future<Either<Failure, List<TransactionRecord>>> getWalletTransactions(
      String id, filter) {
    // TODO: implement getWalletTransactions
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Wallet>>> getWallets(String userIdentifier) {
    // TODO: implement getWallets
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Wallet>> getWalletData(String id) {
    // TODO: implement getWalletData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TransactionState>> handleTransaction(
      String senderId, String recieverId, double amount) {
    // TODO: implement handleTransaction
    throw UnimplementedError();
  }
}
