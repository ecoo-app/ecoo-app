import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/data/e_coupon_library/mock_data.dart';
import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:injectable/injectable.dart';

abstract class IWalletService {
  Future<Either<Failure, List<WalletEntity>>> get allWallets;
  WalletEntity getSelected();
  List<TransactionRecord> getSelectedTransactions();
  Future<void> setSelected(WalletEntity wallet);
  Future<Either<Failure, List<WalletEntity>>> fetchAndUpdateWallets();
  Future<Either<Failure, WalletEntity>> fetchAndUpdateSelected();
  Future<Either<Failure, List<TransactionRecord>>>
      fetchAndUpdateSelectedTransactions();
}

@LazySingleton(as: IWalletService)
class WalletService implements IWalletService {
  final IWalletRepo _walletRepo;
  final ISettingsService _settingsService;
  List<WalletEntity> _wallets;
  WalletEntity _selected = WalletEntity(privateWalletMock);
  List<TransactionRecord> _selectedTransactions = [];

  WalletService(this._walletRepo, this._settingsService);

  @override
  WalletEntity getSelected() {
    return this._selected;
  }

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
      var walletOrFailure = await _walletRepo.getWalletData(walletId);
      walletOrFailure.fold((failure) => null, (success) {
        this._selected = success;
      });
      await fetchAndUpdateSelected();
    } else if (this._selected != wallet) {
      this._selected = wallet;
      await fetchAndUpdateSelected();
    }
  }

  @override
  Future<Either<Failure, List<WalletEntity>>> fetchAndUpdateWallets() async {
    Either<Failure, List<WalletEntity>> result;
    var walletOrFail = await _walletRepo.getWallets('');
    walletOrFail.fold((failure) => result = Left(failure), (success) {
      this._wallets = success;
      result = Right(this._wallets);
    });
    return result;
  }

  @override
  Future<Either<Failure, WalletEntity>> fetchAndUpdateSelected() async {
    return await _walletRepo.getWalletData(this._selected.id);
  }

  @override
  List<TransactionRecord> getSelectedTransactions() {
    return this._selectedTransactions;
  }

  @override
  Future<Either<Failure, List<TransactionRecord>>>
      fetchAndUpdateSelectedTransactions() async {
    var transactionsOrFailure =
        await _walletRepo.getWalletTransactions(_selected.id, null);
    transactionsOrFailure.fold(
        (fail) => null, (success) => this._selectedTransactions = success);

    return transactionsOrFailure;
  }
}
