import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/profile_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class PinVerificationViewModel extends BaseViewModel {
  final IRouter _router;
  final IWalletService _walletService;
  final IProfileService _profileService;
  WalletEntity wallet;
  String pin;

  PinVerificationViewModel(
      this._walletService, this._router, this._profileService);

  void init() {
    wallet = _walletService.getSelected();
  }

  void onVerify(String successText) async {
    setViewState(Loading());

    try {
      var result = await _profileService.verify(pin, wallet);
      if (result) {
        await _router.pushNamed(SuccessRoute,
            arguments: SuccessScreenArguments(
                isShop: wallet.isShop,
                text: successText,
                iconAssetPath: Assets.check_double_svg,
                nextRoute: WalletDetailRoute));

        setViewState(Loaded());
      }
    } on Failure catch (failure) {
      setViewState(Loaded());
      setViewState(Error((failure)));
    } catch (e) {
      print(e);
    }
  }
}
