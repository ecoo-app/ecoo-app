import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/ui/core/services/login_service.dart';
import 'package:e_coupon/ui/core/services/notification_service.dart';
import 'package:e_coupon/ui/core/services/profile_service.dart';
import 'package:e_coupon/ui/core/services/recovery_service.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/mock_implementations.dart';

class RecoveryServiceMock extends Mock implements IRecoveryService {}

void main() {
  ILoginService _loginService;
  ISettingsService _settingsServiceMock;
  IWalletSource _walletSourceMock;
  IProfileService _profileServiceMock;
  INotificationService _notificationServiceMock;
  IRecoveryService _recoveryServiceMock;

  setUp(() {
    _walletSourceMock = WalletSourceMock();
    _settingsServiceMock = SettingsMock();
    _profileServiceMock = ProfileServiceMock();
    _notificationServiceMock = NotificationServiceMock();
    _recoveryServiceMock = RecoveryServiceMock();

    _loginService = LoginService(_walletSourceMock, _settingsServiceMock,
        _profileServiceMock, _notificationServiceMock, _recoveryServiceMock);
  });

  test('login returns false if not token was saved previously', () async {
    when(_settingsServiceMock.identityToken())
        .thenAnswer((realInvocation) => Future.value());

    var result = await _loginService.login();

    expect(result, LoginResult.Onboarding);
  });
}
