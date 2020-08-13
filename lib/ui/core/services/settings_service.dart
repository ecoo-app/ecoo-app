import 'package:e_coupon/ui/core/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISettingsService {
  Future setBool(String key, bool defaultValue);
  Future setStringValue(String key, String value);

  bool getBool(String key);
  String getString(String key);

  Future<void> saveIdentityToken(String token);
  Future<String> identityToken();

  Future<void> writeSecureString(String key, String value);
  Future<String> readSecureString(String key);
}

@Injectable(as: ISettingsService)
class SettingsService implements ISettingsService {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _securePreferences;

  SettingsService(this._sharedPreferences, this._securePreferences);

  @override
  bool getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future setBool(String key, bool defaultValue) {
    return _sharedPreferences.setBool(key, defaultValue);
  }

  @override
  String getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  Future setStringValue(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  @override
  Future<String> identityToken() {
    return _securePreferences.read(key: Constants.identityTokenKey);
  }

  @override
  Future<void> saveIdentityToken(String token) async {
    await _securePreferences.write(
        key: Constants.identityTokenKey, value: token);
  }

  @override
  Future<String> readSecureString(String key) async {
    return await _securePreferences.read(key: key);
  }

  @override
  Future<void> writeSecureString(String key, String value) async {
    await _securePreferences.write(key: key, value: value);
  }
}
