import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';

abstract class IAppService {
  String get appVersion;
}

@Injectable(as: IAppService)
class AppService implements IAppService {
  final PackageInfo _packageInfo;
  String _appVersion = "1.0.0";

  AppService(this._packageInfo);

  @override
  String get appVersion => _packageInfo != null
      ? '${_packageInfo.version}.${_packageInfo.buildNumber}'
      : _appVersion;
}
