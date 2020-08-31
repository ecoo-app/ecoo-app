import 'package:e_coupon/core/extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('string is null or empty', () async {
    expect(''.isNullOrEmpty(), isTrue);
    String test;
    expect(test.isNullOrEmpty(), isTrue);
    expect('test'.isNullOrEmpty(), isFalse);
  });

  test('not null and double', () async {
    expect(''.isNotNullAndDouble(), isFalse);
    String test;
    expect(test.isNotNullAndDouble(), isFalse);
    expect('0.0'.isNotNullAndDouble(), isTrue);
    expect('0'.isNotNullAndDouble(), isTrue);
    expect('asdf'.isNotNullAndDouble(), isFalse);
  });
}
