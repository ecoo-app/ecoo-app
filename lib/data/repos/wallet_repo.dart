import 'dart:async';

import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';

import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/local/local_wallet_source.dart';
import 'package:e_coupon/injection.dart';

import 'package:ecoupon_lib/common/errors.dart';
import 'package:ecoupon_lib/models/currency.dart' as lib;
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:ecoupon_lib/models/paper_wallet.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:ecoupon_lib/models/wallet.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';

import '../network_info.dart';

@prodEnv
@devEnv
@LazySingleton(as: IWalletRepo)
// @lazySingleton
class WalletRepo implements IWalletRepo {
  final ILocalWalletSource localDataSource;
  final INetworkInfo networkInfo;
  final IWalletSource walletSource;

  WalletRepo({this.localDataSource, this.networkInfo, this.walletSource});

  @override
  Future<Either<Failure, Wallet>> createWallet(lib.Currency currency,
      {bool isShop = false}) async {
    Either<Failure, Wallet> result;

    if (await networkInfo.isConnected) {
      try {
        if (currency == null) {
          var currencies = await walletSource.walletService.fetchCurrencies();
          currency = currencies.items[0];
        }
        print('create wallet currency ${currency.name}');
        final wallet = await walletSource.walletService.createWallet(currency);
        print('create wallet wallet ${wallet.walletID}');
        result = Right(wallet);
      } on NotAuthenticatedError {
        result = Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        result = Left(HTTPFailure(e.statusCode));
      } catch (anyerror) {
        print('error $anyerror');
        // TODO log/send error
        result = Left(UnknownFailure());
      }
    } else {
      result = Left(NoService());
    }

    return result;
  }

  @override
  Future<Either<Failure, ListResponse<Transaction>>> getWalletTransactions(
      String id, ListCursor cursor) async {
    Either<Failure, ListResponse<Transaction>> result;

    if (await networkInfo.isConnected) {
      try {
        var transactions = await walletSource.walletService
            .fetchTransactions(walletID: id, cursor: cursor);
        result = Right(transactions);
        //
      } on NotAuthenticatedError {
        result = Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        result = Left(HTTPFailure(e.statusCode));
      }
    } else {
      result = Left(NoService());
    }

    return result;
  }

  @override
  Future<Either<Failure, List<WalletEntity>>> getWallets(
      String userIdentifier) async {
    if (await networkInfo.isConnected) {
      try {
        final wallets = await walletSource.walletService.fetchWallets();
        final walletEntities =
            wallets.items.map((wallet) => WalletEntity(wallet)).toList();
        await localDataSource.cacheWallets(walletsKey, walletEntities);
        return Right(walletEntities);
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure(e.statusCode));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      try {
        final wallets = await localDataSource.getWallets(walletsKey);
        return Right(wallets);
      } catch (e) {
        // type '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'FutureOr<List<WalletEntity>>'
        //CacheException
        print('get walletS $e');
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> getWalletData(String walletID) async {
    if (await networkInfo.isConnected) {
      try {
        final wallet = await walletSource.walletService.fetchWallet(walletID);
        final walletEntity = WalletEntity(wallet);
        unawaited(localDataSource.cacheWallet(singleWalletKey, walletEntity));
        return Right(walletEntity);
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure(e.statusCode));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      try {
        final wallet = await localDataSource.getWallet(singleWalletKey);
        return Right(wallet);
      } catch (e) {
        print('get wallet $e');
        //CacheException
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Transaction>> handleTransaction(
      WalletEntity sender, WalletEntity reciever, int amount) async {
    if (await networkInfo.isConnected) {
      Wallet senderModel = sender.walletModel;
      try {
        if (!(await walletSource.walletService
            .canSignWithWallet(senderModel))) {
          print('cannot sign with wallet');
          var walletMigration =
              await walletSource.walletService.migrateWallet(senderModel);
//
          if (walletMigration.state == TransactionState.done) {
            print('fetch new wallet');
            senderModel = await walletSource.walletService
                .fetchWallet(walletMigration.walletID);
            // TODO update local wallet
            //
          } else if (walletMigration.state == TransactionState.open ||
              walletMigration.state == TransactionState.pending) {
            print('wallet migration state is open or pending');
            //
          } else {
            print('wallet migration has failed');
            return Left(UnknownFailure());
          }
        }
        final transaction = await walletSource.walletService
            .transfer(senderModel, reciever.walletModel, amount);
        return Right(transaction);
      } on NotAuthenticatedError {
        print('not autheticated failure');
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        print('http failure');
        return Left(HTTPFailure(e.statusCode));
      } catch (e) {
        print(e);
        return Left(UnknownFailure());
      }
    } else {
      print('no service failure');
      return Left(NoService());
    }
  }

  @override
  Future<Either<Failure, Transaction>> handlePaperTransfer(
      PaperWallet source, WalletEntity destination, int amount) async {
    if (await networkInfo.isConnected) {
      try {
        final transaction = await walletSource.walletService
            .paperTransfer(source, destination.walletModel, amount);
        return Right(transaction);
      } on NotAuthenticatedError {
        return Left(NotAuthenticatedFailure());
      } on HTTPError catch (e) {
        return Left(HTTPFailure(e.statusCode));
      } catch (e) {
        print('error code $e');
        return Left(UnknownFailure());
      }
    } else {
      return Left(NoService());
    }
  }
}
