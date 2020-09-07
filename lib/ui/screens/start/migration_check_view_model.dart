import 'dart:async';

import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/local/migration_check_source.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/recovery_service.dart';
import 'package:e_coupon/ui/screens/start/migration_check_item.dart';
import 'package:injectable/injectable.dart';

// TODO make this logic readable...!

@injectable
class MigrationCheckViewModel extends BaseViewModel {
  final IMigrationCheckSource _migrationCheckSource;
  final IRecoveryService _recoveryService;
  final IWalletRepo _walletRepo;
  final IRouter _router;
  List<MigrationCheckItem> _migrationChecks = [];
  StreamController _migrationItemsStreamController =
      StreamController<List<MigrationCheckItem>>.broadcast();

  // final MockMigrations _mockMigrations;

  MigrationCheckViewModel(this._recoveryService, this._walletRepo,
      this._migrationCheckSource, this._router);

  Future<void> init() async {
    var savedChecks = await _migrationCheckSource.getChecks();

    if (savedChecks.isNotEmpty) {
      _migrationChecks = savedChecks;
      _migrationItemsStreamController.add(_migrationChecks);
      var migrating = _getMigratingItem(_migrationChecks);
      if (migrating == null) {
        migrating = _migrationChecks.first;
      }
      _startCheck(migrating);
    } else {
      var walletsOrFailure = await _walletRepo.getWallets('');

      walletsOrFailure.fold((failure) => _onFailure(failure),
          (wallets) async => await _onWallets(wallets));

      _startCheck(_migrationChecks.first);
    }
  }

  void _timedChecking(MigrationCheckItem item, WalletEntity wallet) {
    Future.delayed(Duration(seconds: 15), () async {
      try {
        await _checkMigration(item, wallet);
      } on Error catch (e) {
        print(e);
        setViewState(Error(UnknownFailure()));
      }
      // await _handleMigration();
    });
  }

  void _checkMigration(MigrationCheckItem item, WalletEntity wallet) async {
    var isMigratingOrFailure = await _recoveryService.isWalletMigrating(wallet);

    await isMigratingOrFailure.fold((failure) => setViewState(Error(failure)),
        (isMigrating) async {
      if (isMigrating) {
        await _timedChecking(item, wallet);
      } else {
        // start next check
        await _onOneItemMigrated(item);
      }
    });
  }

  void _startCheck(MigrationCheckItem item) async {
    var wallet = item.wallet;

    if (wallet == null) {
      var walletOrFailure = await _walletRepo.getWalletData(item.walletID);
      await walletOrFailure.fold((failure) => _onFailure(failure),
          (walletResult) => wallet = walletResult);
    }

    if (item.state == MigrationStateEnum.Migrating) {
      await _checkMigration(item, wallet);
    } else if (item.state == MigrationStateEnum.Done) {
    } else {
      if (item.state == MigrationStateEnum.WaitingForCheck) {
        item.state = MigrationStateEnum.Checking;

        _migrationItemsStreamController.add(_migrationChecks);
      }

      var canSignOrFailure = await _recoveryService.walletCanSign(wallet);

      await canSignOrFailure.fold((failure) => setViewState(Error(failure)),
          (canSign) async {
        if (!canSign) {
          var migrationOrFailure =
              await _recoveryService.handleWalletMigration(wallet);

          await migrationOrFailure.fold(
              (failure) => setViewState(Error(failure)), (migration) async {
            item.state = MigrationStateEnum.Migrating;

            await _migrationCheckSource.save(_migrationChecks);
            _migrationItemsStreamController.add(_migrationChecks);

            _timedChecking(item, wallet);
          });
        } else {
          await _onOneItemMigrated(item);
        }
      });
    }
  }

  void _onOneItemMigrated(MigrationCheckItem item) async {
    item.state = MigrationStateEnum.Done;
    var next = _getNext(item);
    if (next != null) {
      next.state = MigrationStateEnum.Checking;
      _migrationItemsStreamController.add(_migrationChecks);
      await _startCheck(next);
    } else {
      // checks are over
      await _migrationCheckSource.eraseAll();
      await _router.pushAndRemoveUntil(WalletDetailRoute, '');
    }
  }

  /// return item which is migrating or null
  MigrationCheckItem _getMigratingItem(List<MigrationCheckItem> items) {
    for (var checkItem in items) {
      if (checkItem.state == MigrationStateEnum.Migrating) {
        return checkItem;
      }
    }
    return null;
  }

  MigrationCheckItem _getNext(MigrationCheckItem previous) {
    for (var i = 0; i < _migrationChecks.length; i++) {
      if (_migrationChecks[i].walletID == previous.walletID &&
          i + 1 < _migrationChecks.length) {
        return _migrationChecks[i + 1];
      }
    }
    return null;
  }

  void _onWallets(List<WalletEntity> wallets) async {
    if (wallets != null) {
      for (var wallet in wallets) {
        _migrationChecks.add(MigrationCheckItem(
            MigrationStateEnum.WaitingForCheck, wallet.id,
            wallet: wallet));
      }
      await _migrationCheckSource.save(_migrationChecks);
      _migrationItemsStreamController.add(_migrationChecks);
    }
  }

  void _onFailure(Failure failure) {
    setViewState(Error(failure));
  }

  Stream<List<MigrationCheckItem>> get migrationItemsStream =>
      _migrationItemsStreamController.stream;

  // void onFakeMigration(MigrationCheckItem item) {
  //   print('tap');
  //   _mockMigrations.mockMigrations['${item.walletID}'] = TransactionState.done;
  // }
}
