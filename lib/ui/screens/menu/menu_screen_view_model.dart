import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/app_service.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class MenuScreenViewModel extends BaseViewModel {
  final IAppService _appService;
  final IRouter router;

  MenuScreenViewModel(this._appService, this.router);

  String get appVersion => _appService.appVersion;

  Future<void> onboarding() async {
    await router.pushNamed(OnboardingRoute);
  }

  Future<void> close() {
    router.pop();
    return Future.value();
  }
}
