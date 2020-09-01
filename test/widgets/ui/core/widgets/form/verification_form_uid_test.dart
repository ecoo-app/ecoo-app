import 'package:e_coupon/ui/core/widgets/form/verification_form_uid.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('initial state of the form field', (WidgetTester tester) async {
    var model = UidVerificationInput();
    var widget = VerificationFormUid(
      model: model,
    );

    await tester.pumpWidget(MaterialWrapper.wrap(widget));
    expect(find.text('CHE-'), findsNWidgets(1));
    expect(model.value, '');
    expect(model.hasNoUid, false);
  });

  testWidgets('ticking no UID number checkbox sets no uid field',
      (WidgetTester tester) async {
    var model = UidVerificationInput();
    var widget = VerificationFormUid(
      model: model,
    );

    await tester.pumpWidget(MaterialWrapper.wrap(widget));
    expect(model.hasNoUid, false);

    await tester.tap(find.byType(Checkbox));

    expect(model.hasNoUid, true);
  });

  Future<void> testInputOfUidNumber(
      WidgetTester tester, String input, String expected) async {
    var model = UidVerificationInput();
    var widget = VerificationFormUid(
      model: model,
    );

    await tester.pumpWidget(MaterialWrapper.wrap(widget));

    var inputFinder = find.byKey(Key('uid-input'));

    await tester.enterText(inputFinder, input);

    expect(model.value, expected);
  }

  group('Verify UID Inputs', () {
    testWidgets('Complete UID', (WidgetTester tester) async {
      await testInputOfUidNumber(tester, '123.456.789', 'CHE-123.456.789');
    });
    testWidgets('Incomplete', (WidgetTester tester) async {
      await testInputOfUidNumber(tester, '12353789', '');
    });
    testWidgets('Missing One Part', (WidgetTester tester) async {
      await testInputOfUidNumber(tester, '123456', '');
    });
    testWidgets('Allow only numeric', (WidgetTester tester) async {
      await testInputOfUidNumber(tester, '12yadsf', '');
    });

    testWidgets('max length is three numbers', (WidgetTester tester) async {
      await testInputOfUidNumber(tester, '123.456.789', 'CHE-123.456.789');
    });
  });
}
