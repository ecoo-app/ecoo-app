import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/services/login_service.dart';
import 'package:e_coupon/ui/core/services/recovery_service.dart';
import 'package:ecoupon_lib/services/session_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterScreenViewModel extends BaseViewModel {
  final IRouter _router;
  final ILoginService _loginService;
  final IRecoveryService _recoveryService;

  RegisterScreenViewModel(
      this._router, this._loginService, this._recoveryService);

  Future<void> registerWithApple() async {
    var loggedIn = await _loginService.register(AuthProvider.apple.convert());
    if (loggedIn) {
      await _onLoginResult();
    }

    return Future.value();
  }

  Future<void> registerWithGoogle() async {
    var result = await _loginService.register(AuthProvider.google.convert());
    if (result) {
      await _onLoginResult();
    }

    return Future.value();
  }

  Future<void> _onLoginResult() async {
    // TODO Wallet already available? failures
    var hasWalletsOrFailure = await _recoveryService.userHasWallets();

    await hasWalletsOrFailure.fold((l) => null, (hasWallets) async {
      if (hasWallets) {
        await _router.pushAndRemoveUntil(MigrationRoute, '');
      } else {
        await _router.pushAndRemoveUntil(WalletSelectionRoute, '');
      }
    });
  }

  Future<void> onboarding() async {
    await _router.pushAndRemoveUntil(OnboardingRoute, '');
  }

  Future<bool> isAppleAvailable() {
    return _loginService.isAppleAvailable;
  }
}
