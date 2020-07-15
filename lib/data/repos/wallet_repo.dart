import 'dart:async';

import 'package:e_coupon/business/entities/currency.dart';
import 'package:e_coupon/business/entities/verification_input.dart';
import 'package:e_coupon/business/entities/verification_state.dart';
import 'package:e_coupon/data/lib/mock_data.dart';
import 'package:e_coupon/data/lib/mock_library.dart' as libAPI;
import 'package:e_coupon/data/model/currency_model.dart';
import 'package:e_coupon/data/model/wallet_model.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/transaction_state.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/local/local_wallet_source.dart';
import 'package:injectable/injectable.dart';

import '../network_info.dart';

@LazySingleton(as: IWalletRepo)
class WalletRepo implements IWalletRepo {
  final ILocalWalletSource localDataSource;
  final libAPI.ILibWalletSource libDataSource;
  final INetworkInfo networkInfo;

  WalletRepo({this.localDataSource, this.networkInfo, this.libDataSource});

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
  Future<Either<Failure, List<Wallet>>> getCachedWallets(String id) async {
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
  Future<Either<Failure, Wallet>> getCachedWalletData(String id) {
    return _getMockWalletData(id);
  }

  @override
  Future<Either<Failure, List<Wallet>>> getWallets(
      String userIdentifier) async {
    if (await networkInfo.isConnected) {
      try {
        // TODO use lib
        final wallets = await _getMockWallets();
        localDataSource.cacheWallets('wallets', wallets);
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
  Future<Either<Failure, Wallet>> getWalletData(String id) {
    return _getMockWalletData(id);
  }

  @override
  Future<Either<Failure, TransactionState>> handleTransaction(
      String senderId, String recieverId, double amount) {
    return _makeMockTransaction();
  }

  @override
  Future<Either<Failure, VerificationState>> verifyWallet(
      String walletId, List<String> verificationInputs) {
    return _mockVerification();
  }

  @override
  Future<Either<Failure, List<VerificationInput>>> getVerificationInputs(
      String currencyId, bool isShop) async {
    Either<Failure, List<VerificationInput>> result;

    libDataSource
        .getVerificationInputs(currencyId, isShop)
        .then((value) => result = Right(value))
        .catchError((error) => result = Left(MessageFailure(error)));

    return result;
    // try {
    //   var inputs =
    //       await libDataSource.getVerificationInputs(currencyId, isShop);
    //   result = Right(inputs);
    // } catch (error) {
    //   result = Left(error);
    // }

    // return result;
  }

  /// mock code
  Future<Either<Failure, List<TransactionRecord>>> _getMockTransactions(
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

  Future<List<Wallet>> _getMockWallets() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      var completer = Completer<List<Wallet>>();

      completer.complete(
        MockWallets.map((wallet) {
          return WalletModel(
              id: wallet.walletId,
              amount: wallet.amount,
              currency: Currency(
                  id: wallet.currency.id, label: wallet.currency.label),
              isShop: wallet.isShop);
        }).toList(),
      );

      return completer.future;
    });
  }

  Future<Either<Failure, Wallet>> _getMockWalletData(id) {
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
              isShop: wallet.isShop)));
          return completer.future;
        }
      }

      return null;
    });
  }

  Future<Either<Failure, TransactionState>> _makeMockTransaction() {
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

  Future<Either<Failure, VerificationState>> _mockVerification() {
    return Future.delayed(const Duration(milliseconds: 400), () {
      var completer = Completer<Either<Failure, VerificationState>>();
      completer.complete(Right(Verified()));
      return completer.future;
    });
  }
}
