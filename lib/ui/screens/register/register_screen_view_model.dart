import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/services/login_service.dart';
import 'package:ecoupon_lib/services/session_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterScreenViewModel extends BaseViewModel {
  final IRouter _router;
  final ILoginService _loginService;

  RegisterScreenViewModel(this._router, this._loginService);

  Future<void> registerWithApple() async {
    var loggedIn = await _loginService.register(AuthProvider.apple.convert());
    if (loggedIn) {
      // TODO Wallet already available?
      await _router.pushAndRemoveUntil(RegisterWalletTypeRoute, '');
    }

    return Future.value();
  }

  Future<void> registerWithGoogle() async {
    var result = await _loginService.register(AuthProvider.google.convert());
    if (result) {
      // TODO Wallet already available?
      await _router.pushNamed(RegisterWalletTypeRoute);
    }

    return Future.value();
  }

  Future<void> onboarding() async {
    await _router.pushAndRemoveUntil(OnboardingRoute, '');
  }

  Future<bool> isAppleAvailable() {
    return _loginService.isAppleAvailable;
  }
}
