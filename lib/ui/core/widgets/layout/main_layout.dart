import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/header/main_header.dart';
import 'package:flutter/material.dart';

enum BackButtonType { Close, Back }

class MainLayout extends StatelessWidget {
  final bool isShop;
  final String title;
  final Widget body;
  final VoidCallback onBackPressed;
  final BackButtonType leadingType;

  MainLayout(
      {this.isShop,
      this.title,
      this.body,
      this.onBackPressed,
      this.leadingType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO waiting for this: https://github.com/joostlek/GradientAppBar/pulls pull request to merge and support shapes
      // until then i just copied the code, fixed it and added it as widget
      // appBar: GradientAppBar(
      //   // leading: Icon(
      //   //   Icons.arrow_back,
      //   //   color: Colors.white,
      //   // ),
      //   shape: AppBarShapeBorder(),
      //   title: Text(
      //     title,
      //     textAlign: TextAlign.end,
      //     style: TextStyles.body_text_white,
      //   ),
      //   gradient: isShop
      //       ? GradientStyles.shopWalletAppbarGradient
      //       : GradientStyles.privateWalletAppbarGradient,
      //   elevation: 0,
      // ),
      appBar: MainHeader(
          leadingIcon: leadingType == BackButtonType.Close
              ? Assets.close_svg
              : Assets.back_svg,
          headline: title,
          gradient: isShop
              ? GradientStyles.shopWalletAppbarGradient
              : GradientStyles.privateWalletAppbarGradient,
          onBack: () {
            if (onBackPressed != null) {
              onBackPressed();
            }
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: Container(
            margin:
                const EdgeInsets.only(left: 24, right: 24, top: 36, bottom: 48),
            child: body),
      ),
    );
  }
}

class AppBarShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    print(rect.height);
    // final double extraHeight = 15.0;
    // final double stepWidth = 20.0;

    // Path path = Path();
    // path.lineTo(0, rect.height + extraHeight);
    // path.lineTo(50.0, rect.height + extraHeight);
    // path.lineTo(50.0 + stepWidth, rect.height);
    // path.lineTo(rect.width, rect.height);
    // path.lineTo(rect.width, 0.0);
    // path.close();

    // return path;
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, rect.height);
    path.lineTo(90, rect.height);
    path.cubicTo(
        100, rect.height, 100, rect.height - 14, 110, rect.height - 14);
    // path.cubicTo(0, 0, -1, 0, -1, 0);
    // path.cubicTo(-1, 0, -1, rect.height, -1, rect.height);
    // path.cubicTo(-1, rect.height, -0.75, rect.height, -0.75, rect.height);
    // path.cubicTo(
    //     -0.69, rect.height, -0.7, rect.height * 1.02, -0.67, rect.height * 0.9);
    // path.cubicTo(-0.66, rect.height * 0.85, -0.65, rect.height * 0.86, -0.6,
    //     rect.height * 0.86);
    // path.cubicTo(
    //     -0.6, rect.height * 0.86, 0, rect.height * 0.86, 0, rect.height * 0.86);
    path.lineTo(rect.width, rect.height - 14);
    path.lineTo(rect.width, 0);
    path.close();

    return path;
  }
}
