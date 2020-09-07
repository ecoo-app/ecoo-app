import 'package:e_coupon/ui/core/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ThirdPartyLibraryModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  FlutterSecureStorage get securePrefs => FlutterSecureStorage();

  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  LocalStorage get localStorage => LocalStorage(Constants.localStorageKey);
}
