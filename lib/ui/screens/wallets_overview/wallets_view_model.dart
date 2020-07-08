import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/use_cases/get_all_wallets.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';

import 'package:injectable/injectable.dart';

@injectable
class WalletsViewModel extends BaseViewModel {
  List<Wallet> _wallets = [];
  final GetAllWallets getAllWallets;

  WalletsViewModel({this.getAllWallets});

  List<Wallet> get wallets => _wallets;

  get state => null;

  void loadWallets() async {
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
