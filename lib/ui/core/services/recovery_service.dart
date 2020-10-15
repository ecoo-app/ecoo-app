import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/local/migration_check_source.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:ecoupon_lib/models/wallet_migration.dart';
import 'package:injectable/injectable.dart';

abstract class IRecoveryService {
  Future<Either<Failure, bool>> walletCanSign(IWalletEntity wallet);
  Future<Either<Failure, WalletMigration>> handleWalletMigration(
      IWalletEntity wallet);
  Future<Either<Failure, bool>> isWalletMigrating(IWalletEntity walletentity);
  Future<Either<Failure, List<WalletMigration>>> getMigrationsFor(
      IWalletEntity walletentity);
  Future<Either<Failure, bool>> userHasWallets();
  Future<Either<Failure, bool>> migrationInProcess();
}

// @devEnv
// @lazySingleton
// class MockMigrations {
//   Map<String, TransactionState> mockMigrations = {};
// }

// @devEnv
// @LazySingleton(as: IRecoveryService)
// class MockRecoveryService implements IRecoveryService {
//   final MockMigrations _mockMigrations;
//   final IWalletRepo _walletRepo;

//   MockRecoveryService(this._mockMigrations, this._walletRepo);

//   @override
//   Future<Either<Failure, List<WalletMigration>>> getMigrationsFor(
//       WalletEntity walletentity) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, WalletMigration>> handleWalletMigration(
//       WalletEntity wallet) {
//     print('handle wallet migration for wallet ${wallet.id}');
//     _mockMigrations.mockMigrations['${wallet.id}'] = TransactionState.pending;
//     return Future.value(Right(null));
//   }

//   @override
//   Future<Either<Failure, bool>> isWalletMigrating(WalletEntity wallet) {
//     var item = _mockMigrations.mockMigrations['${wallet.id}'];
//     return Future.value(Right(
//         item == TransactionState.pending || item == TransactionState.open));
//   }

//   @override
//   Future<Either<Failure, bool>> walletCanSign(WalletEntity wallet) {
//     return Future.value(Right(false));
//   }

//   @override
//   Future<Either<Failure, bool>> userHasWallets() async {
//     Either<Failure, bool> result;
//     var walletsOrFailure = await _walletRepo.getWallets('');
//     walletsOrFailure.fold((failure) => result = Left(failure), (wallets) {
//       if (wallets.isNotEmpty) {
//         result = Right(true);
//       } else {
//         result = Right(false);
//       }
//     });
//     return result;
//   }

//   @override
//   Future<Either<Failure, bool>> migrationInProcess() {
//     return Future.value(Right(false));
//   }
// }

@LazySingleton(as: IRecoveryService)
class RecoveryService implements IRecoveryService {
  final IWalletRepo _walletRepo;
  final IMigrationCheckSource _migrationCheckSource;

  RecoveryService(this._walletRepo, this._migrationCheckSource);

  @override
  Future<Either<Failure, bool>> walletCanSign(IWalletEntity wallet) async {
    return _walletRepo.walletCanSign(wallet);
  }

  @override
  Future<Either<Failure, WalletMigration>> handleWalletMigration(
      IWalletEntity wallet) async {
    Either<Failure, WalletMigration> result;

    var isMigratingOrFailure = await isWalletMigrating(wallet);

    await isMigratingOrFailure.fold((failure) => result = Left(failure),
        (isMigrating) async {
      if (!isMigrating) {
        result = await _walletRepo.migrateWallet(wallet);
      } else {
        // TODO what to do if it is migrating?
        var walletMigrationsOrFailure = await getMigrationsFor(wallet);
        walletMigrationsOrFailure.fold((failure) => result = Left(failure),
            (walletMigrations) {
          result = Right(walletMigrations.last);
        });
      }
    });

    return result;
  }

  @override
  Future<Either<Failure, bool>> isWalletMigrating(
      IWalletEntity walletentity) async {
    Either<Failure, bool> result;
    var walletMigrationsOrFailure = await getMigrationsFor(walletentity);

    walletMigrationsOrFailure.fold((failure) => result = Left(failure),
        (walletMigrations) {
      if (walletMigrations == null || walletMigrations.isEmpty) {
        result = Right(false);
      } else {
        result = Right(
            (walletMigrations.last.state == TransactionState.pending ||
                walletMigrations.last.state == TransactionState.open));
      }
    });

    return result;
  }

  @override
  Future<Either<Failure, List<WalletMigration>>> getMigrationsFor(
      IWalletEntity walletentity) async {
    return _walletRepo.fetchAllWalletMigrationsForWallet(walletentity.id);
  }

  @override
  Future<Either<Failure, bool>> userHasWallets() async {
    Either<Failure, bool> result;
    var walletsOrFailure = await _walletRepo.getWallets('');
    walletsOrFailure.fold((failure) => result = Left(failure), (wallets) {
      if (wallets.isNotEmpty) {
        result = Right(true);
      } else {
        result = Right(false);
      }
    });
    print('check user has wallets');
    print(result);
    return result;
  }

  @override
  Future<Either<Failure, bool>> migrationInProcess() async {
    var savedChecks = await _migrationCheckSource.getChecks();

    // if there are still checks to do
    if (savedChecks != null && savedChecks.isNotEmpty) {
      print(savedChecks);
      return Right(true);
    }

    Either<Failure, bool> result = Right(false);

    final fetchedMigrationsOrFailure =
        await _walletRepo.fetchAllWalletMigrations();
    fetchedMigrationsOrFailure.fold((failure) => result = Left(failure),
        (migrations) {
      if (migrations != null) {
        var migrationsInProcess = migrations.where((migration) =>
            migration.state == TransactionState.open ||
            migration.state == TransactionState.pending);
        if (migrationsInProcess.isNotEmpty) {
          result = Right(true);
        }
      } else {
        result = Right(false);
      }
    });

    return result;
  }
}
