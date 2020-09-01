import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  test('default state is not a valid Phone number', () async {
    var data = PhoneNumberVerificationInput();

    expect(data.value, '');
    expect(data.isValid, isFalse);
  });

  void _testInput(String value, String expected, bool isValid) {
    var data = PhoneNumberVerificationInput();
    data.setValue(value);
    expect(data.isValid, isValid);
    expect(data.value, expected);
  }

  test('valid input', () async {
    _testInput('77 111 22 33', '+41771112233', true);
  });

  test('partial input is not valid', () async {
    _testInput('77 123 12 23 3', '', false); // Input too long
    _testInput('1', '', false); // Input too short
  });
}
