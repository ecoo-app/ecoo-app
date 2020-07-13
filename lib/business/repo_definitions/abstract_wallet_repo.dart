import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/transaction_state.dart';
import 'package:e_coupon/business/entities/verification_state.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/core/failure.dart';

abstract class IWalletRepo {
  // TODO how to make intelligent cache handling?
  Future<Either<Failure, List<Wallet>>> getCachedWallets(String userIdentifier);

  Future<Either<Failure, List<Wallet>>> getWallets(String userIdentifier);

  Future<Either<Failure, Wallet>> getCachedWalletData(String id);

  Future<Either<Failure, Wallet>> getWalletData(String id);

  Future<Either<Failure, List<TransactionRecord>>> getCachedWalletTransactions(
      String id, filter);

  Future<Either<Failure, List<TransactionRecord>>> getWalletTransactions(
      String id, filter); // and pagination cursor?

  Future<Either<Failure, TransactionState>> handleTransaction(
      String senderId, String recieverId, double amount);

  Future<Either<Failure, VerificationState>> verifyWallet(
      String walletId, List<String> verificationInputs);
}
