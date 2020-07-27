import 'dart:async';

import 'package:e_coupon/business/entities/verification_form.dart';
import 'package:e_coupon/business/entities/verification_state.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/lib/mock_data.dart';
import 'package:e_coupon/data/lib/mock_library.dart' as lib_api;
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/data/lib/lib_wallet_source.dart';

import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/local/local_wallet_source.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';

import '../network_info.dart';

@LazySingleton(as: IWalletRepo)
class WalletRepo implements IWalletRepo {
  final ILocalWalletSource localDataSource;
  final lib_api.ILibWalletSource libDataSource;
  final INetworkInfo networkInfo;
  final IWalletSource walletSource;

  WalletRepo(
      {this.localDataSource,
      this.networkInfo,
      this.libDataSource,
      this.walletSource});

  @override
  Future<Either<Failure, List<TransactionRecord>>> getCachedWalletTransactions(
      String id, filter) {
    return _getMockTransactions(id, filter);
  }

  @override
  Future<Either<Failure, List<TransactionRecord>>> getWalletTransactions(
      String id, filter) {
    return _getMockTransactions(id, filter);
  }

  @override
  Future<Either<Failure, List<WalletEntity>>> getCachedWallets(
      String id) async {
    try {
      final wallets = await localDataSource.getWallets(
          'wallets'); // todo does it return an empty string if no wallets cached?
      return Right(wallets);
    } on Exception catch (error) {
      //CacheException
      print(error);
      // return Left(CacheFailure());
      return Left(MessageFailure(error));
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> getCachedWalletData(String id) {
    return _getMockWalletData(id);
  }

  @override
  Future<Either<Failure, List<WalletEntity>>> getWallets(
      String userIdentifier) async {
    if (await networkInfo.isConnected) {
      try {
        // TODO use lib
        final wallets = await _getMockWallets();
        unawaited(localDataSource.cacheWallets('wallets', wallets));
        return Right(wallets);
      } on MessageFailure {
        //ServerException
        return Left(ServerFailure());
      }
    } else {
      try {
        final wallets = await localDataSource.getWallets('wallets');
        return Right(wallets);
      } on MessageFailure {
        //CacheException
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> getWalletData(String id) {
    return _getMockWalletData(id);
  }

  @override
  Future<Either<Failure, Transaction>> handleTransaction(
      WalletEntity sender, WalletEntity reciever, int amount) async {
    Either<Failure, Transaction> result;

    if (await networkInfo.isConnected) {
      await walletSource.walletService
          .transfer(sender.walletModel, reciever.walletModel, amount)
          .then((value) => result = Right(value))
          .catchError(
              (error) => result = Left(MessageFailure(error.toString())));
      // await _makeMockTransaction().then((value) => result = Right(value));
    } else {
      result = Left(NoService());
    }

    return result;
  }

  @override
  Future<Either<Failure, VerificationState>> verifyWallet(
      String walletId, List<String> verificationInputs) {
    return _mockVerification();
  }

  @override
  Future<Either<Failure, VerificationForm>> getVerificationInputs(
      String currencyId, bool isShop) async {
    Either<Failure, VerificationForm> result;

    await libDataSource
        .getVerificationInputs(currencyId, isShop)
        .then((value) => result = Right(value))
        .catchError((error) => result = Left(MessageFailure(error)));

    return result;
  }

  /// mock code
  Future<Either<Failure, List<TransactionRecord>>> _getMockTransactions(
      id, filter) {
    // mock delay
    return Future.delayed(const Duration(milliseconds: 400), () {
      for (final wallet in MockWallets) {
        if (wallet.id == id) {
          var completer = Completer<Either<Failure, List<TransactionRecord>>>();
          completer.complete(Right(_getTransactions(wallet.isShop)));
          return completer.future;
        }
      }
      return null;
    });
  }

  Future<List<WalletEntity>> _getMockWallets() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      var completer = Completer<List<WalletEntity>>();

      // completer.complete(
      //   MockWallets.map((wallet) {
      //     return wallet;
      //   }).toList(),
      // );

      completer.complete(MockWallets);

      return completer.future;
    });
  }

  Future<Either<Failure, WalletEntity>> _getMockWalletData(id) {
    return Future.delayed(const Duration(milliseconds: 600), () {
      var completer = Completer<Either<Failure, WalletEntity>>();
      for (final wallet in MockWallets) {
        if (wallet.id == id) {
          // generate a future
          completer.complete(Right(wallet));
          return completer.future;
        }
      }

      completer.complete(Left(MessageFailure('No such wallet with ID $id')));
      return completer.future;
    });
  }

  Future<Transaction> _makeMockTransaction() {
    return Future.delayed(const Duration(milliseconds: 400), () {
      var completer = Completer<Transaction>();
      completer.complete(Transaction(
          PrivateWalletID, ShopWalletID, 2000, '', DateTime.now())); // TODO
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

  Future<Either<Failure, VerificationState>> _mockVerification() {
    return Future.delayed(const Duration(milliseconds: 400), () {
      var completer = Completer<Either<Failure, VerificationState>>();
      completer.complete(Right(Verified()));
      return completer.future;
    });
  }
}
