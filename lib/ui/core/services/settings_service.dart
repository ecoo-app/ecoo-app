import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISettingsService {
  Future setBool(String key, bool defaultValue);
  Future setStringValue(String key, String value);

  bool getBool(String key);
  String getString(String key);
}

@Injectable(as: ISettingsService)
class SettingsService implements ISettingsService {
  final SharedPreferences _sharedPreferences;

  SettingsService(this._sharedPreferences);

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
}
