import 'package:e_coupon/ui/core/widgets/form/verification_form_phone.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('initial value of form field', (WidgetTester tester) async {
    var model = PhoneNumberVerificationInput();
    var widget = VerificationFormPhoneField(
      model: model,
      label: 'phonenumber',
    );

    await tester.pumpWidget(MaterialWrapper.wrap(widget));
    expect(find.text('phonenumber'), findsNWidgets(1));
    expect(find.text('+41 '), findsNWidgets(1));
    expect(model.value, '');
  });

  Future<void> testInputFormats(WidgetTester tester, String input,
      String expected, String modelValue) async {
    var model = PhoneNumberVerificationInput();
    var widget = VerificationFormPhoneField(
      model: model,
      label: 'phonenumber',
    );
    await tester.pumpWidget(MaterialWrapper.wrap(widget));
    await tester.enterText(find.byWidget(widget), input);
    expect(find.text(expected), findsNWidgets(1));
    expect(model.value, modelValue);
  }

  testWidgets('Input correct phone format with whitespace',
      (WidgetTester tester) async {
    await testInputFormats(
        tester, '78 123 45 67', '78 123 45 67', '+41781234567');
  });

  testWidgets('Input correct phone format without whitespace',
      (WidgetTester tester) async {
    await testInputFormats(tester, '781234567', '78 123 45 67', '+41781234567');
  });

  testWidgets('Input correct phone format with partial input',
      (WidgetTester tester) async {
    await testInputFormats(tester, '781234', '78 123 4', '');
  });
}
