import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class PinVerificationViewModel extends BaseViewModel {
  final IRouter _router;
  final IWalletService _walletService;
  final IWalletSource _walletSource;
  WalletEntity wallet;
  String pin;

  PinVerificationViewModel(
      this._walletService, this._walletSource, this._router);

  void init() {
    wallet = _walletService.getSelected();
  }

  void onVerify(String successText) async {
    setViewState(Loading());
    // TODO
    print('pin verification is not yet implemented on backend. send $pin');
    _walletSource.walletService;

    await _router.pushNamed(SuccessRoute,
        arguments: SuccessScreenArguments(
            isShop: true,
            text: successText,
            iconAssetPath: Assets.check_double_svg));
    setViewState(Loaded());
  }
}
