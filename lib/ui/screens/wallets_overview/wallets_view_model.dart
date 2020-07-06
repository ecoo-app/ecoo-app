import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/use_cases/get_all_wallets.dart';

import 'package:e_coupon/ui/core/base_view_model.dart';
import 'package:e_coupon/ui/core/viewstate.dart';
import 'package:injectable/injectable.dart';

@injectable
class WalletsViewModel extends BaseViewModel {
  List<Wallet> _wallets = [];
  final GetAllWallets getAllWallets;

  WalletsViewModel({this.getAllWallets});

  List<Wallet> get wallets => _wallets;

  void loadWallets() async {
    setState(ViewStateEnum.Busy);

    var walletsOrFailure =
        await getAllWallets(AllWalletParams(userIdentifier: 'string'));
    walletsOrFailure.fold(
        (failure) => print('FAILURE'), (wallets) => _wallets = wallets);

    setState(ViewStateEnum.Idle);
  }
}
