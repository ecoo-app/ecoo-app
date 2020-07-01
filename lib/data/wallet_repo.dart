import 'dart:async';

import 'package:e_coupon/business/abstract_wallet_repo.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/mock_data.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IWalletRepo)
class WalletRepo implements IWalletRepo {
  @override
  Future<Either<Failure, List<Transaction>>> getWalletTransactions(id, filter) {
    return getMockTransactions(id, filter);
  }

  @override
  Future<Either<Failure, List<Wallet>>> getWallets(userIdentifier) {
    return getMockWallets();
  }

  @override
  Future<Either<Failure, Wallet>> getWalletData(id) {
    return getMockWalletData(id);
  }

  /// mock code
  getMockTransactions(id, filter) {
    for (final wallet in MockWallets) {
      if (wallet.id == id) {
        var completer = Completer<Either<Failure, List<Transaction>>>();
        completer.complete(Right(wallet.transactions));
        return completer.future;
      }
    }

    return null;
  }

  getMockWallets() {
    var completer = Completer<Either<Failure, List<Wallet>>>();
    completer.complete(Right(MockWallets));
    return completer.future;
  }

  getMockWalletData(id) {
    for (final wallet in MockWallets) {
      if (wallet.id == id) {
        // generate a future
        var completer = Completer<Either<Failure, Wallet>>();
        completer.complete(Right(wallet));
        return completer.future;
      }
    }

    return null;
  }
}
