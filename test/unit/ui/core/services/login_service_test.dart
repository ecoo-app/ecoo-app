import 'package:e_coupon/ui/core/services/login_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ILoginService _loginService;

  setUp(() {
    _loginService = LoginService();
  });

  test('login returns true if authenticated', () async {
    var result = await _loginService.login();
    expect(result, isFalse);
  });
}
