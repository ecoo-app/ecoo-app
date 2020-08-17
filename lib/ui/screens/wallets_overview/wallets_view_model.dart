import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';

import 'package:injectable/injectable.dart';

@injectable
class WalletsViewModel extends BaseViewModel {
  final IWalletService _walletService;
  final IRouter _router;
  final INetworkInfo _networkInfo;

  WalletsViewModel(this._walletService, this._router, this._networkInfo);

  Either<Failure, List<WalletEntity>> get wallets =>
      Right(_walletService.wallets);

  Future<Either<Failure, List<WalletEntity>>> get futureWallets =>
      _walletService.fetchAndUpdateWallets();

  Future<bool> get isConnected => _networkInfo.isConnected;

  WalletEntity getSelected() {
    return _walletService.getSelected();
  }

  void setSelected(WalletEntity wallet) async {
    await _router.pop();
    await _walletService.setSelected(wallet);
  }

  void select(WalletEntity wallet) {
    _walletService.setSelected(wallet);
    _router.pushNamed(WalletDetailRoute);
  }
}
