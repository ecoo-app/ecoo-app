import 'dart:async';

import 'package:e_coupon/business/abstract_wallet_repo.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/mock_data.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';

class WalletRepo implements IWalletRepo {
  @override
  Future<Either<Failure, List<Transaction>>> getWalletTransactions(id, filter) {
    for (final wallet in MockWallets) {
      if (wallet.id == id) return wallet.transactions;
    }

    return null;
  }

  @override
  List<Wallet> getWallets() {
    return MockWallets;
  }

  @override
  Future<Either<Failure, Wallet>> getWalletData(id) {
    for (final wallet in MockWallets) {
      if (wallet.id == id) {
        var completer = Completer<Either<Failure, Wallet>>();
        completer.complete(Right(wallet));
        return completer.future;
      }
    }

    return null;
  }
}
