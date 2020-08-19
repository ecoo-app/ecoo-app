import 'package:e_coupon/ui/core/widgets/button/rhombus_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  Future<void> testButton(
      WidgetTester tester, bool isPrivate, String text) async {
    bool wasTapped = false;

    var button = RhombusButton(
      private: true,
      text: text,
      onTap: () {
        wasTapped = true;
      },
    );

    await tester.pumpWidget(MaterialWrapper.wrap(button));
    expect(find.text(text), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(2));

    await tester.pump();
    await tester.tap(find.byType(Text));
    await tester.pump();
    expect(wasTapped, isTrue);
  }

  testWidgets('button contains text and svg background on private wallet type',
      (WidgetTester tester) async {
    await testButton(tester, true, 'private');
  });

  testWidgets('button contains text and svg background on shop wallet type',
      (WidgetTester tester) async {
    await testButton(tester, false, 'shop');
  });
}
