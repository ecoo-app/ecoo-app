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

  Future<void> testInputOfUidNumber(WidgetTester tester, String part1,
      String part2, String part3, String expected) async {
    var model = UidVerificationInput();
    var widget = VerificationFormUid(
      model: model,
    );

    await tester.pumpWidget(MaterialWrapper.wrap(widget));

    var part1Finder = find.byKey(Key('uid-part-1'));
    var part2Finder = find.byKey(Key('uid-part-2'));
    var part3Finder = find.byKey(Key('uid-part-3'));

    await tester.enterText(part1Finder, part1);
    await tester.enterText(part2Finder, part2);
    await tester.enterText(part3Finder, part3);

    expect(model.value, expected);
  }

  group('Verify UID Inputs', () {
    testWidgets('Complete UID', (WidgetTester tester) async {
      await testInputOfUidNumber(
          tester, '123', '456', '789', 'CHE-123.456.789');
    });
    testWidgets('Incomplete', (WidgetTester tester) async {
      await testInputOfUidNumber(tester, '123', '56', '789', '');
    });
    testWidgets('Missing One Part', (WidgetTester tester) async {
      await testInputOfUidNumber(tester, '123', '456', '', '');
    });
    testWidgets('Allow only numeric', (WidgetTester tester) async {
      await testInputOfUidNumber(tester, '12yadsf', '456', '', '');
    });

    testWidgets('max length is three numbers', (WidgetTester tester) async {
      await testInputOfUidNumber(
          tester, '12312', '456', '789', 'CHE-123.456.789');
    });
  });
}
