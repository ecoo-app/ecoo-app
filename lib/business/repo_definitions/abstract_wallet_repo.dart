import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/transaction_state.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:meta/meta.dart';

abstract class IWalletRepo {
  Future<Either<Failure, List<Wallet>>> getWallets(String userIdentifier);
  Future<Either<Failure, Wallet>> getWalletData(String id);
  Future<Either<Failure, List<Transaction>>> getWalletTransactions(
      String id, filter); // and pagination cursor?
  Future<Either<Failure, TransactionState>> handleTransaction(
      String senderId, String recieverId, double amount);
}
