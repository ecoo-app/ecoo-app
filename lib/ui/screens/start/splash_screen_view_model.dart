import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/login_service.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/services/notification_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashScreenViewModel extends BaseViewModel {
  final IRouter _router;
  final ILoginService _loginService;
  final INotificationService _notificationService;

  SplashScreenViewModel(
      this._router, this._loginService, this._notificationService);

  Future<void> startup() async {
    try {
      var loginResult = await _loginService.login();
      switch (loginResult) {
        case LoginResult.Home:
          await _notificationService.registerDevice();
          await _router.pushAndRemoveUntil(WalletDetailRoute, '');
          break;
        case LoginResult.Onboarding:
          await _router.pushAndRemoveUntil(OnboardingRoute, '');
          break;
        default:
          await _router.pushAndRemoveUntil(OnboardingRoute, '');
      }
    } catch (e) {
      print(e);
    }

    return Future.value();
  }
}
