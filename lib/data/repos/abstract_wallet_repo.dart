import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/verification_form.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:ecoupon_lib/models/transaction_list_response.dart';
import 'package:ecoupon_lib/models/verification_input_data.dart';
import 'package:ecoupon_lib/models/wallet.dart';

abstract class IWalletRepo {
  Future<Either<Failure, List<WalletEntity>>> getCachedWallets(
      String userIdentifier);

  Future<Either<Failure, List<WalletEntity>>> getWallets(String userIdentifier);

  Future<Either<Failure, WalletEntity>> getCachedWalletData(String id);

  Future<Either<Failure, WalletEntity>> getWalletData(String id);

  Future<Either<Failure, List<TransactionRecord>>> getCachedWalletTransactions(
      String id, filter);

  Future<Either<Failure, TransactionListResponse>> getWalletTransactions(
      String id, TransactionListCursor cursor);

  Future<Either<Failure, Transaction>> handleTransaction(
      WalletEntity sender, WalletEntity reciever, int amount);

  Future<Either<Failure, VerificationForm>> getVerificationInputs(
      Currency currency, bool isShop);

  Future<Either<Failure, Wallet>> verifyWallet(
      Wallet wallet, List<VerificationInputData> verificationInputs);
}
