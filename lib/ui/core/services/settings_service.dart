import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISettingsService {
  Future setBool(String key, bool defaultValue);

  bool getBool(String key);
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
}
