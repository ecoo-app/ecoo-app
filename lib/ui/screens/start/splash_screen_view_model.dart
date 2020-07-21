import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/login_service.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashScreenViewModel extends BaseViewModel {
  final IRouter _router;
  final ILoginService _loginService;
  final ISettingsService _settingsService;

  SplashScreenViewModel(
      this._router, this._loginService, this._settingsService);

  Future<void> startup() async {
    try {
      // Show Register Screen if needed
      var loginResult = await _loginService.login();
      if (loginResult) {
        await _router.pushAndRemoveUntil(HomeRoute, '');
        return;
      } else {
        // Show Onboarding if needed
        var onboardingComplete = _settingsService
                .getBool(Constants.firstInstallCompleteSettingsKey) ??
            false;
        if (!onboardingComplete) {
          await _router.pushAndRemoveUntil(OnboardingRoute, '');
          return;
        } else {
          await _router.pushAndRemoveUntil(RegisterRoute, '');
        }
      }
    } catch (e) {
      //
      print(e);
    }

    return Future.value();
  }
}
