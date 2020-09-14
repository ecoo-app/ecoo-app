import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:e_coupon/ui/screens/verification/verification_input_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  test('verification contains all possible form inputs', () async {
    var data = VerificationInputData();
    expect(data, isNotNull);
    expect(data.uid, isNotNull);
    expect(data.address, isNotNull);
    expect(data.companyName, isNotNull);
    expect(data.firstName, isNotNull);
    expect(data.lastName, isNotNull);
  });

  test('default state is not a valid form', () async {
    var data = VerificationInputData();

    expect(data.isValid(false), isFalse);
  });

  test('private wallet is valid on mandatory fields', () async {
    var data = VerificationInputData();

    expect(data.isValid(false), isFalse);
    data.firstName.setValue('hans');
    data.lastName.setValue('gruber');
    data.dateOfBirth.setValue(DateTime.now());
    data.phoneNumber.setValue('+41791234567');
    data.address.setValue(
        Address(street: 'Dorfstrasse 27', city: 'Zürich', postalCode: '8037'));
    data.origin.setCity('Zürich');
    expect(data.isValid(false), isFalse);
    data.onIsThruthChanged(true);

    expect(data.isValid(false), isTrue);
  });

  test('shop wallet is valie on mandatory fields if UID is provided', () async {
    var data = VerificationInputData();

    expect(data.isValid(true), isFalse);
    data.companyName.setValue('fivenine');
    data.address.setValue(
        Address(street: 'Dorfstrasse 27', city: 'Zürich', postalCode: '8037'));
    data.uid.setValue('123.000.000');

    expect(data.isValid(true), isFalse);
    data.onIsThruthChanged(true);

    expect(data.isValid(true), isTrue);
  });

  test('shop wallet is valid if no uid is set', () async {
    var data = VerificationInputData();

    expect(data.isValid(true), isFalse);
    data.companyName.setValue('fivenine');
    data.noUidStreet.setValue('Dorfstrasse 27');
    data.noUidCity.setValue('Zürich');
    data.noUidPostalCode.setValue('8037');
    data.uid.hasNoUidChanged(true);

    expect(data.isValid(true), isFalse);
    data.onIsThruthChanged(true);

    expect(data.isValid(true), isTrue);
  });
}
