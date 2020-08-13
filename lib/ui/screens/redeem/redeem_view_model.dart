import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class RedeemViewModel extends BaseViewModel {
  final IWalletService _walletService;
  // final IWalletSource _walletSource;
  final IRouter _router;
  WalletEntity wallet;
  String nameOfBank;
  String iban;
  String owner;

  RedeemViewModel(this._walletService, this._router);

  void init() {
    wallet = _walletService.getSelected();
  }

  void onRedeem(String successText) async {
    setViewState(Loading());
    print(
        'redeem is not yet implemented on backend. send $nameOfBank $iban $owner');
    await _router.pushNamed(SuccessRoute,
        arguments: SuccessScreenArguments(
          isShop: true,
          text: successText,
          iconAssetPath: Assets.envelope_open_dollar_svg,
          nextRoute: WalletDetailRoute,
        ));
    setViewState(Loaded());
  }
}
