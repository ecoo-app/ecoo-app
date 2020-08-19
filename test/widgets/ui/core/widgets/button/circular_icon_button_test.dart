import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/circular_icon_button.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('renders text in button', (WidgetTester tester) async {
    var button = CircularIconButton(
      text: 'test',
      iconAsset: Assets.shop_envelope_open_dollar_svg,
      onPressed: () {},
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    expect(find.byType(CircularIconButton), findsNWidgets(1));
    expect(find.text('test'), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('button can be pressed', (WidgetTester tester) async {
    bool wasPressed = false;
    var button = PrimaryButton(
      text: 'test',
      onPressed: () {
        wasPressed = true;
      },
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    await tester.tap(find.byWidget(button));
    expect(wasPressed, isTrue);
  });
}
