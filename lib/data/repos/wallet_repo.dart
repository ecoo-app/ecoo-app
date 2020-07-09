import 'dart:async';

import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/data/lib/mock_data.dart';
import 'package:e_coupon/data/model/currency_model.dart';
import 'package:e_coupon/data/model/wallet_model.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/transaction_state.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:e_coupon/data/local/local_wallet_source.dart';
import 'package:injectable/injectable.dart';

import '../../injection.dart';
import '../network_info.dart';

@Environment(Env.dev)
@LazySingleton(as: IWalletRepo)
class WalletRepo implements IWalletRepo {
  final ILocalWalletSource localDataSource;
  // final ILibWalletSource libDataSource;
  final NetworkInfo networkInfo;

  WalletRepo({this.localDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<TransactionRecord>>> getCachedWalletTransactions(
      String id, filter) {
    return getMockTransactions(id, filter);
  }

  @override
  Future<Either<Failure, List<TransactionRecord>>> getWalletTransactions(
      String id, filter) {
    return getMockTransactions(id, filter);
  }

  @override
  Future<Either<Failure, List<Wallet>>> getCachedWallets(String id) async {
    try {
      final wallets = await localDataSource.getWallets(
          'wallets'); // todo does it return an empty string if no wallets cached?
      return Right(wallets);
    } on Exception catch (error) {
      //CacheException
      print(error);
      // return Left(CacheFailure());
      return Left(Excep(error));
    }
  }

  @override
  Future<Either<Failure, Wallet>> getCachedWalletData(String id) {
    return getMockWalletData(id);
  }

  @override
  Future<Either<Failure, List<Wallet>>> getWallets(
      String userIdentifier) async {
    if (await networkInfo.isConnected) {
      try {
        // TODO use lib
        final wallets = await getMockWallets();
        localDataSource.cacheWallets('wallets', wallets);
        return Right(wallets);
      } on Error {
        //ServerException
        return Left(ServerFailure());
      }
    } else {
      try {
        final wallets = await localDataSource.getWallets('wallets');
        return Right(wallets);
      } on Error {
        //CacheException
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Wallet>> getWalletData(String id) {
    return getMockWalletData(id);
  }

  @override
  Future<Either<Failure, TransactionState>> handleTransaction(
      String senderId, String recieverId, double amount) {
    return makeMockTransaction();
  }

  /// mock code
  Future<Either<Failure, List<TransactionRecord>>> getMockTransactions(
      id, filter) {
    // mock delay
    return Future.delayed(const Duration(milliseconds: 400), () {
      for (final wallet in MockWallets) {
        if (wallet.walletId == id) {
          var completer = Completer<Either<Failure, List<TransactionRecord>>>();
          completer.complete(Right(_getTransactions(wallet.isShop)));
          return completer.future;
        }
      }
      return null;
    });
  }

  Future<List<Wallet>> getMockWallets() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      var completer = Completer<List<Wallet>>();

      completer.complete(
        MockWallets.map((wallet) {
          return WalletModel(
              id: wallet.walletId,
              amount: wallet.amount,
              currency: Currency(
                  id: wallet.currency.id, label: wallet.currency.label),
              isShop: wallet.isShop,
              transactions: _getTransactions(wallet.isShop));
        }).toList(),
      );

      return completer.future;
    });
  }

  Future<Either<Failure, Wallet>> getMockWalletData(id) {
    return Future.delayed(const Duration(milliseconds: 600), () {
      for (final wallet in MockWallets) {
        if (wallet.walletId == id) {
          // generate a future
          var completer = Completer<Either<Failure, Wallet>>();
          completer.complete(Right(WalletModel(
              amount: wallet.amount,
              id: wallet.walletId,
              currency: CurrencyModel(
                  id: wallet.currency.id, label: wallet.currency.label),
              isShop: wallet.isShop,
              transactions: _getTransactions(wallet.isShop))));
          return completer.future;
        }
      }

      return null;
    });
  }

  Future<Either<Failure, TransactionState>> makeMockTransaction() {
    return Future.delayed(const Duration(milliseconds: 400), () {
      var completer = Completer<Either<Failure, TransactionState>>();
      completer.complete(Right(TransactionState())); // TODO
      return completer.future;
    });
  }

  List<TransactionRecord> _getTransactions(bool isShop) {
    if (isShop) {
      return MockTransactionWalletShop.map((transRecord) => TransactionRecord(
            text: transRecord.text,
            amount: transRecord.amount,
            isEncashment: transRecord.tags.contains(MockEncashmentTag()),
          )).toList();
    } else {
      return MockTransactionWalletPrivate.map(
          (transRecord) => TransactionRecord(
                text: transRecord.text,
                amount: transRecord.amount,
              )).toList();
    }
  }
}
