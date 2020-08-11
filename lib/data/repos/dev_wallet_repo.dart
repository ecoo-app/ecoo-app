import 'dart:async';

import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/mock_data.dart';

import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/local/local_wallet_source.dart';
import 'package:e_coupon/data/repos/mock_wallet_repo.dart';
import 'package:e_coupon/data/repos/wallet_repo.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/services/mock_login_service.dart';
import 'package:ecoupon_lib/models/currency.dart' as lib;
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:ecoupon_lib/models/wallet.dart';
import 'package:injectable/injectable.dart';

@devEnv
@LazySingleton(as: IWalletRepo)
class DevWalletRepo implements IWalletRepo {
  final ILocalWalletSource localDataSource;

  final bool useMock = true;

  final MockLoginService _mockLoginService;
  final WalletRepo _walletRepo = getIt<WalletRepo>();
  final MockWalletRepo _mockWalletRepo = getIt<MockWalletRepo>();

  DevWalletRepo(this.localDataSource, this._mockLoginService);

  @override
  Future<Either<Failure, Wallet>> createWallet(lib.Currency currency,
      {bool isShop = false}) async {
    await _mockLoginService.testLogin(false);
    return _walletRepo.createWallet(currency, isShop: isShop);
  }

  @override
  Future<Either<Failure, ListResponse<Transaction>>> getWalletTransactions(
      String id, ListCursor cursor) async {
    if (useMock) {
      return _mockWalletRepo.getWalletTransactions(id, cursor);
    } else {
      await _mockLoginService.testLogin(false);
      return _walletRepo.getWalletTransactions(id, cursor);
    }
  }

  @override
  Future<Either<Failure, List<WalletEntity>>> getWallets(
      String userIdentifier) async {
    // if (useMock) {
    //   return _mockWalletRepo.getWallets(userIdentifier);
    // } else {
    await _mockLoginService.testLogin(false);
    return _walletRepo.getWallets(userIdentifier);
    // }
  }

  @override
  Future<Either<Failure, WalletEntity>> getWalletData(String id) async {
    print(id);
    if (useMock) {
      return _getMockWalletData(id);
    } else {
      if (id != PrivateWalletID && id != ShopWalletID) {
        await _mockLoginService.testLogin(false);
        return _walletRepo.getWalletData(id);
      }
      return _getMockWalletData(id);
    }
  }

  @override
  Future<Either<Failure, Transaction>> handleTransaction(
      WalletEntity sender, WalletEntity reciever, int amount) async {
    if (useMock) {
      return _mockWalletRepo.handleTransaction(sender, reciever, amount);
    } else {
      await _mockLoginService.testLogin(false);
      return _walletRepo.handleTransaction(sender, reciever, amount);
    }
  }

  /// mock code

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
}
