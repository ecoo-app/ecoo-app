import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'dart:io' show Platform;

abstract class IAppService {
  String get appVersion;
}

@Injectable(as: IAppService)
class AppService implements IAppService {
  final PackageInfo _packageInfo;
  String _appVersion = "1.0.0";

  AppService(this._packageInfo);

  String get appVersion {
    if (_packageInfo == null) {
      return _appVersion;
    }

    if (Platform.isAndroid) {
      return _packageInfo.version;
    }
    if (Platform.isIOS) {
      return _packageInfo.buildNumber;
    }

    return _appVersion;
  }
}
