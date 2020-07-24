import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/verification_form.dart';
import 'package:e_coupon/business/entities/verification_state.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:ecoupon_lib/models/transaction.dart';

abstract class IWalletRepo {
  Future<Either<Failure, List<WalletEntity>>> getCachedWallets(
      String userIdentifier);

  Future<Either<Failure, List<WalletEntity>>> getWallets(String userIdentifier);

  Future<Either<Failure, WalletEntity>> getCachedWalletData(String id);

  Future<Either<Failure, WalletEntity>> getWalletData(String id);

  Future<Either<Failure, List<TransactionRecord>>> getCachedWalletTransactions(
      String id, filter);

  Future<Either<Failure, List<TransactionRecord>>> getWalletTransactions(
      String id, filter); // and pagination cursor?

  Future<Either<Failure, Transaction>> handleTransaction(
      WalletEntity sender, WalletEntity reciever, int amount);

  Future<Either<Failure, VerificationForm>> getVerificationInputs(
      String currencyId, bool isShop);

  Future<Either<Failure, VerificationState>> verifyWallet(
      String walletId, List<String> verificationInputs);
}
