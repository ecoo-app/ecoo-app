import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/use_cases/get_all_wallets.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';

import 'package:injectable/injectable.dart';

@injectable
class WalletsViewModel extends BaseViewModel {
  List<WalletEntity> _wallets = [];
  final GetAllWallets getAllWallets;

  WalletsViewModel({this.getAllWallets});

  List<WalletEntity> get wallets => _wallets;

  get state => null;

  Future<void> loadWallets() async {
    // setState(ViewStateEnum.Busy);
    setViewState(Loading());

    var walletsOrFailure =
        await getAllWallets(AllWalletParams(userIdentifier: 'string'));
    walletsOrFailure.fold(
        (failure) => print('FAILURE'), (wallets) => _wallets = wallets);

    setViewState(Loaded());
    // setState(ViewStateEnum.Idle);
  }
}
