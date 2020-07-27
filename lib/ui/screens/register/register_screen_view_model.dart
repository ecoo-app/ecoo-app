import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterScreenViewModel extends BaseViewModel {
  final IRouter _router;

  RegisterScreenViewModel(this._router);

  Future<void> close() {
    //_router.pop();
    return Future.value();
  }

  Future<void> registerWithApple() {
    return Future.value();
  }

  Future<void> registerWithGoogle() {
    _router.pushNamed(RegisterWalletTypeRoute);
    return Future.value();
  }

  Future<void> onboarding() async {
    await _router.pushAndRemoveUntil(OnboardingRoute, '');
  }
}
