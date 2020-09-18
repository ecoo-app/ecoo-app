import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:ecoupon_lib/models/list_response.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

// TODO clean up
abstract class IWalletService {
  Future<Either<Failure, List<WalletEntity>>> get allWallets;
  WalletEntity getSelected();
  ListResponse<Transaction> getSelectedTransactions();
  Future<void> setSelected(WalletEntity wallet);
  Future<Either<Failure, List<WalletEntity>>> fetchAndUpdateWallets();
  Future<Either<Failure, WalletEntity>> fetchAndUpdateSelected();
  Future<Either<Failure, ListResponse<Transaction>>>
      fetchAndUpdateSelectedTransactions(ListCursor cursor);
  List<WalletEntity> get wallets;

  Stream<WalletEntity> get walletStream;

  Stream<List<WalletEntity>> get walletsStream;

  Future<Either<Failure, void>> updateSelected();
}

// @prodEnv
@LazySingleton(as: IWalletService)
class WalletService implements IWalletService {
  final IWalletRepo _walletRepo;
  final ISettingsService _settingsService;
  List<WalletEntity> _wallets = [];
  WalletEntity _selected;
  ListResponse<Transaction> _selectedTransactions = ListResponse([], null);
  StreamController _walletStreamController =
      StreamController<WalletEntity>.broadcast();

  BehaviorSubject<List<WalletEntity>> _walletsSubject = BehaviorSubject();

  WalletService(this._walletRepo, this._settingsService);

  @override
  WalletEntity getSelected() {
    return this._selected;
  }

  List<WalletEntity> get wallets => this._wallets;

  @override
  Future<Either<Failure, List<WalletEntity>>> get allWallets async {
    if (_wallets == null || _wallets.isEmpty) {
      return fetchAndUpdateWallets();
    }
    return Right(this._wallets);
  }

  @override
  Future<void> setSelected(WalletEntity wallet) async {
    if (this._selected == null || wallet == null) {
      String walletId =
          await _settingsService.getString(Constants.lastWalletIDSettingsKey);

      // TODO error handlin!
      if (walletId == null) {
        var walletsOrFailure = await _walletRepo.getWallets('');
        walletsOrFailure.fold((failure) => null, (success) {
          this._selected = success[0];
        });
      } else {
        var walletOrFailure = await _walletRepo.getWalletData(walletId);
        walletOrFailure.fold((failure) => null, (success) {
          this._selected = success;
        });
      }

      if (this._selected != null) {
        await fetchAndUpdateSelected(); // hä? this does not do anything
      }
    } else if (this._selected != wallet) {
      await _settingsService.setStringValue(
          Constants.lastWalletIDSettingsKey, wallet.id);
      this._selected = wallet;
      if (this._selected != null) {
        await fetchAndUpdateSelected(); // hä? this does not do anything
      }
    }
    _walletStreamController.add(this._selected);
  }

  @override
  Future<Either<Failure, List<WalletEntity>>> fetchAndUpdateWallets() async {
    Either<Failure, List<WalletEntity>> result;
    var walletOrFail = await _walletRepo.getWallets('');
    walletOrFail.fold((failure) {
      result = Left(failure);
    }, (success) {
      if (success != null) {
        this._wallets = success;
        _walletsSubject.add(success);
      }
      result = Right(this._wallets);
    });
    return result;
  }

  @override
  Future<Either<Failure, WalletEntity>> fetchAndUpdateSelected() async {
    if (this._selected == null) {
      await setSelected(null);
    }
    return await _walletRepo.getWalletData(this._selected.id);
  }

  @override
  Future<Either<Failure, void>> updateSelected() async {
    var walletOrFailure = await fetchAndUpdateSelected();
    return walletOrFailure.fold((failure) {
      return Left(failure);
    }, (wallet) {
      this._selected = wallet;
      _walletStreamController.add(this._selected);
      return Right(null);
    });
  }

  @override
  ListResponse<Transaction> getSelectedTransactions() {
    return this._selectedTransactions;
  }

  @override
  Future<Either<Failure, ListResponse<Transaction>>>
      fetchAndUpdateSelectedTransactions(ListCursor cursor) async {
    var transactionsOrFailure =
        await _walletRepo.getWalletTransactions(_selected.id, cursor);
    transactionsOrFailure.fold(
        (fail) => null, (success) => this._selectedTransactions = success);

    return transactionsOrFailure;
  }

  @override
  Stream<WalletEntity> get walletStream => _walletStreamController.stream;

  @override
  Stream<List<WalletEntity>> get walletsStream => _walletsSubject.stream;
}
