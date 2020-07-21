import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnboardingScreenViewModel extends BaseViewModel {
  final IRouter _router;
  final ISettingsService _settingsService;

  OnboardingScreenViewModel(this._router, this._settingsService);

  Future<void> complete() async {
    await _settingsService.setBool(
        Constants.firstInstallCompleteSettingsKey, true);
    await _router.pushAndRemoveUntil(RegisterRoute, '');
  }
}
