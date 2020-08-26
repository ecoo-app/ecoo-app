import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/app_service.dart';
import 'package:e_coupon/ui/core/services/login_service.dart';
import 'package:e_coupon/ui/core/services/notification_service.dart';
import 'package:e_coupon/ui/core/services/profile_service.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServiceMock extends Mock implements IAppService {}

class RouterMock extends Mock implements IRouter {}

class WalletRepositoryMock extends Mock implements IWalletRepo {}

class WalletServiceMock extends Mock implements IWalletService {}

class NetworkInfoMock extends Mock implements INetworkInfo {}

class LoginServiceMock extends Mock implements ILoginService {}

class SettingsServiceMock extends Mock implements ISettingsService {}

class NotificationServiceMock extends Mock implements INotificationService {}

class WalletSourceMock extends Mock implements IWalletSource {}

class SettingsMock extends Mock implements ISettingsService {}

class ProfileServiceMock extends Mock implements IProfileService {}

class SharedPreferencesMock extends Mock implements SharedPreferences {}

class SecureStorageMock extends Mock implements FlutterSecureStorage {}
