import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('renders text in button', (WidgetTester tester) async {
    var button = PrimaryButton(
      text: 'test',
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    expect(find.byType(OutlineButton), findsNWidgets(1));
    expect(find.text('test'), findsOneWidget);
  });

  testWidgets('renders box decoration', (WidgetTester tester) async {
    var button = PrimaryButton(
      text: 'test',
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    expect(find.byType(DecoratedBox), findsNWidgets(1));
  });

  testWidgets('enabled button can be tapped', (WidgetTester tester) async {
    bool wasPressed = false;
    var button = PrimaryButton(
      text: 'test',
      isEnabled: true,
      onPressed: () {
        wasPressed = true;
      },
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    await tester.tap(find.byWidget(button));
    expect(wasPressed, isTrue);
  });

  testWidgets('disabled button cannot be tapped', (WidgetTester tester) async {
    bool wasPressed = false;
    var button = PrimaryButton(
      text: 'test',
      isEnabled: false,
      onPressed: () {
        wasPressed = true;
      },
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    await tester.tap(find.byWidget(button));
    expect(wasPressed, isFalse);
  });

  testWidgets('isLoading shows progress indicator to button',
      (WidgetTester tester) async {
    var button = PrimaryButton(
      text: 'test',
      isLoading: true,
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));

    expect(find.byType(ECProgressIndicator), findsOneWidget);
  });
}
