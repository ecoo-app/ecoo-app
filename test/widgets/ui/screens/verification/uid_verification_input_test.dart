import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  test('default state is not a valid UID', () async {
    var data = UidVerificationInput();

    expect(data.value, '');
    expect(data.isValid, isFalse);
  });

  void _testInput(String value, String expected, bool isValid) {
    var data = UidVerificationInput();
    data.setValue(value);
    expect(data.isValid, isValid);
    expect(data.value, expected);
  }

  test('valid input', () async {
    _testInput('123.456.789', 'CHE-123.456.789', true);
  });

  test('partial input is not valid', () async {
    _testInput('000.00', '', false);
    _testInput('123.456.789.9', '', false); // Input too long
    _testInput('345.678.99', '', false); // Input too short
  });
}
