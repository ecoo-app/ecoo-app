import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:ecoupon_lib/models/currency.dart' as lib;
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:ecoupon_lib/models/wallet.dart';

abstract class IWalletRepo {
  Future<Either<Failure, List<WalletEntity>>> getWallets(String userIdentifier);

  Future<Either<Failure, WalletEntity>> getWalletData(String id);

  Future<Either<Failure, ListResponse<Transaction>>> getWalletTransactions(
      String id, ListCursor cursor);

  Future<Either<Failure, Transaction>> handleTransaction(
      WalletEntity sender, WalletEntity reciever, int amount);

  Future<Either<Failure, Wallet>> createWallet(lib.Currency currency,
      {bool isShop = false});
}
