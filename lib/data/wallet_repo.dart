import 'dart:async';

import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/transaction_state.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/data/mock_data.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IWalletRepo)
class WalletRepo implements IWalletRepo {
  @override
  Future<Either<Failure, List<TransactionRecord>>> getWalletTransactions(
      id, filter) {
    return getMockTransactions(id, filter);
  }

  @override
  Future<Either<Failure, List<Wallet>>> getWallets(String userIdentifier) {
    return getMockWallets();
  }

  @override
  Future<Either<Failure, Wallet>> getWalletData(String id) {
    return getMockWalletData(id);
  }

  @override
  Future<Either<Failure, TransactionState>> handleTransaction(
      String senderId, String recieverId, double amount) {
    print('starting transaction from $senderId to $recieverId about $amount');
    return makeMockTransaction();
  }

  /// mock code
  Future<Either<Failure, List<TransactionRecord>>> getMockTransactions(
      id, filter) {
    // mock delay
    return Future.delayed(const Duration(milliseconds: 400), () {
      for (final wallet in MockWallets) {
        if (wallet.id == id) {
          var completer = Completer<Either<Failure, List<TransactionRecord>>>();
          completer.complete(Right(wallet.transactions));
          return completer.future;
        }
      }
      return null;
    });
  }

  Future<Either<Failure, List<Wallet>>> getMockWallets() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      var completer = Completer<Either<Failure, List<Wallet>>>();
      completer.complete(Right(MockWallets));
      return completer.future;
    });
  }

  Future<Either<Failure, Wallet>> getMockWalletData(id) {
    return Future.delayed(const Duration(milliseconds: 600), () {
      for (final wallet in MockWallets) {
        if (wallet.id == id) {
          // generate a future
          var completer = Completer<Either<Failure, Wallet>>();
          completer.complete(Right(wallet));
          return completer.future;
        }
      }

      return null;
    });
  }

  Future<Either<Failure, TransactionState>> makeMockTransaction() {
    return Future.delayed(const Duration(milliseconds: 400), () {
      var completer = Completer<Either<Failure, TransactionState>>();
      completer.complete(Right(MockTransactionState));
      return completer.future;
    });
  }
}
