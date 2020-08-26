import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helper/mock_implementations.dart';

void main() {
  ISettingsService _settings;
  FlutterSecureStorage _secureStorageMock;
  SharedPreferences _sharedPrefsMock;

  setUp(() {
    _sharedPrefsMock = SharedPreferencesMock();
    _secureStorageMock = SecureStorageMock();

    _settings = SettingsService(_sharedPrefsMock, _secureStorageMock);
  });

  test('not a first run does not clear credentials', () async {
    when(_sharedPrefsMock.getBool(Constants.notFirstInstallKey))
        .thenReturn(true);

    await _settings.clearCredentialsOnFirstStart();
    verify(_sharedPrefsMock.getBool(Constants.notFirstInstallKey));

    verifyNever(_secureStorageMock.deleteAll());
    verify(_sharedPrefsMock.setBool(Constants.notFirstInstallKey, true));
  });

  test('first install clears credentials', () async {
    when(_sharedPrefsMock.getBool(Constants.notFirstInstallKey))
        .thenReturn(false);

    await _settings.clearCredentialsOnFirstStart();
    verify(_sharedPrefsMock.getBool(Constants.notFirstInstallKey));

    verify(_secureStorageMock.deleteAll());
    verify(_sharedPrefsMock.setBool(Constants.notFirstInstallKey, true));
  });
}
