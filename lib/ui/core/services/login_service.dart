import 'package:injectable/injectable.dart';

abstract class ILoginService {
  Future<bool> login();

  Future<bool> register();
}

@Injectable(as: ILoginService)
class LoginService implements ILoginService {
  @override
  Future<bool> login() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return true;
  }

  @override
  Future<bool> register() {
    throw UnimplementedError();
  }
}
