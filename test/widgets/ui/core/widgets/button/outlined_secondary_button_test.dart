import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('renders text in button', (WidgetTester tester) async {
    var button = OutlinedSecondaryButton(
      text: 'test',
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    expect(find.byType(OutlineButton), findsNWidgets(1));
    expect(find.text('test'), findsOneWidget);
  });

  testWidgets('button can be tapped', (WidgetTester tester) async {
    bool wasPressed = false;
    var button = OutlinedSecondaryButton(
      text: 'test',
      onPressed: () {
        wasPressed = true;
      },
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    await tester.tap(find.byWidget(button));
    expect(wasPressed, isTrue);
  });

  testWidgets('svg asset is rendered', (WidgetTester tester) async {
    var button = OutlinedSecondaryButton(
      text: 'test',
      svgAsset: Assets.icon_qrcode_svg,
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    expect(find.byType(SvgPicture), findsOneWidget);
  });
}
