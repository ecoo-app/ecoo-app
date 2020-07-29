import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';

import 'package:injectable/injectable.dart';

@injectable
class WalletsViewModel extends BaseViewModel {
  List<WalletEntity> _wallets = [];
  final IWalletService _walletService;

  WalletsViewModel(this._walletService);

  List<WalletEntity> get wallets => _wallets;

  Future<void> loadWallets() async {
    setViewState(Loading());

    var failureOrWallets = await _walletService.allWallets;
    failureOrWallets.fold((failure) => setViewState(Error(failure)),
        (result) => _wallets = result);

    setViewState(Loaded());
  }

  void setSelected(WalletEntity wallet) async {
    await _walletService.setSelected(wallet);
  }

  Future<void> onPullToRefresh() async {
    setViewState(Loading());

    var failureOrWallets = await _walletService.fetchAndUpdateWallets();
    failureOrWallets.fold((failure) => setViewState(Error(failure)),
        (result) => _wallets = result);

    setViewState(Loaded());
  }
}
