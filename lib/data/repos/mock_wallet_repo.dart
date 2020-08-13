import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/user_profile.dart';
import 'package:e_coupon/injection.dart';
import 'package:ecoupon_lib/models/currency.dart' as lib;
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:ecoupon_lib/models/paper_wallet.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';

import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/mock_data.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/local/local_wallet_source.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:ecoupon_lib/models/wallet.dart';

import '../network_info.dart';

@mockEnv
@LazySingleton(as: IWalletRepo)
// @lazySingleton
class MockWalletRepo implements IWalletRepo {
  final ILocalWalletSource localDataSource;
  final INetworkInfo networkInfo;
  final IWalletSource walletSource;

  MockWalletRepo({this.localDataSource, this.networkInfo, this.walletSource});

  @override
  Future<Either<Failure, ListResponse<Transaction>>> getWalletTransactions(
      String id, ListCursor cursor) async {
    return _getMockTransactions(id, cursor);
  }

  // @override
  // Future<Either<Failure, List<WalletEntity>>> getCachedWallets(
  //     String id) async {
  //   try {
  //     final wallets = await localDataSource.getWallets(
  //         'wallets'); // todo does it return an empty string if no wallets cached?
  //     return Right(wallets);
  //   } on Exception catch (error) {
  //     //CacheException
  //     print(error);
  //     // return Left(CacheFailure());
  //     return Left(MessageFailure(error));
  //   }
  // }

  @override
  Future<Either<Failure, List<WalletEntity>>> getWallets(
      String userIdentifier) async {
    if (await networkInfo.isConnected) {
      try {
        print('is connected');
        final wallets = await _getMockWallets();
        unawaited(localDataSource.cacheWallets('wallets', wallets));
        return Right(wallets);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        print('not connected');
        final wallets = await localDataSource.getWallets('wallets');
        return Right(wallets);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> getWalletData(String id) async {
    // if (await networkInfo.isConnected) {
    try {
      print('is connected');
      final wallet = await _getMockWalletData(id);
      unawaited(localDataSource.cacheWallet('wallet', wallet));
      return Right(wallet);
    } catch (e) {
      return Left(ServerFailure());
    }
    // } else {
    //   try {
    //     print('not connected');
    //     final wallet = await localDataSource.getWallet('wallet');
    //     return Right(wallet);
    //   } catch (e) {
    //     return Left(CacheFailure());
    //   }
    // }
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

  /// mock code
  Future<Either<Failure, ListResponse<Transaction>>> _getMockTransactions(
      id, filter) {
    // mock delay
    return Future.delayed(const Duration(milliseconds: 400), () {
      for (final wallet in MockWallets) {
        if (wallet.id == id) {
          var completer =
              Completer<Either<Failure, ListResponse<Transaction>>>();
          completer.complete(Right(_getTransactions(wallet.isShop)));
          return completer.future;
        }
      }
      return Right(ListResponse([], null));
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

  Future<WalletEntity> _getMockWalletData(id) {
    return Future.delayed(const Duration(milliseconds: 600), () {
      var completer = Completer<WalletEntity>();
      for (final wallet in MockWallets) {
        if (wallet.id == id) {
          // generate a future
          completer.complete(wallet);
          return completer.future;
        }
      }

      completer.complete(null);
      return completer.future;
    });
  }

  // ignore: unused_element
  Future<Transaction> _makeMockTransaction() {
    return Future.delayed(const Duration(milliseconds: 400), () {
      var completer = Completer<Transaction>();
      completer.complete(Transaction('uid', PrivateWalletID, ShopWalletID, 2000,
          TransactionState.done, DateTime.now(), '', 0, 'sig')); // TODO
      return completer.future;
    });
  }

  ListResponse<Transaction> _getTransactions(bool isShop) {
    var transactions = [];
    if (isShop) {
      transactions = MockTransactionWalletShop;
    } else {
      transactions = MockTransactionWalletPrivate;
    }
    transactions.sort((a, b) => b.created.compareTo(a.created));
    return ListResponse(transactions, null);
  }

  // ignore: unused_element
  Future<Either<Failure, Wallet>> _mockVerification(Wallet wallet) {
    return Future.delayed(const Duration(milliseconds: 400), () {
      var completer = Completer<Either<Failure, Wallet>>();
      completer.complete(Right(Wallet(
          wallet.walletID,
          wallet.publicKey,
          wallet.currency,
          wallet.category,
          wallet.balance,
          WalletState.verified)));
      return completer.future;
    });
  }

  @override
  Future<Either<Failure, Wallet>> createWallet(lib.Currency currency,
      {bool isShop = false}) {
    // TODO: implement createWallet
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Transaction>> handlePaperTransfer(
      PaperWallet source, WalletEntity destination, int amount) {
    // TODO: implement handlePaperTransfer
    throw UnimplementedError();
  }

    @override
  Future<Either<Failure, ProfileEntity>> createProfile(WalletEntity walletEntity, ProfileEntity profile) {
      // TODO: implement createProfile
      throw UnimplementedError();
    }
  
    @override
    Future<Either<Failure, List<ProfileEntity>>> profiles() {
      // TODO: implement profiles
      throw UnimplementedError();
    }
  
    @override
    Future<Either<Failure, bool>> verify(ProfileEntity  profile, String pin) {
    // TODO: implement verify
    throw UnimplementedError();
  }
}
