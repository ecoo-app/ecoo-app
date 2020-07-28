import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/use_cases/get_all_wallets.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';

import 'package:injectable/injectable.dart';

@injectable
class WalletsViewModel extends BaseViewModel {
  List<WalletEntity> _wallets = [];
  final GetAllWallets getAllWallets;
  final IWalletService _walletService;

  WalletsViewModel(this.getAllWallets, this._walletService);

  List<WalletEntity> get wallets => _wallets;

  Future<void> loadWallets() async {
    _wallets = _walletService.wallets;

    setViewState(Loading());

    var walletsOrFailure =
        await getAllWallets(AllWalletParams(userIdentifier: 'string'));
    walletsOrFailure.fold(
        (failure) => print('FAILURE'), (wallets) => _wallets = wallets);

    _walletService.wallets = _wallets;

    setViewState(Loaded());
  }
}
