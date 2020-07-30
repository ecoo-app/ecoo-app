import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final bool isShop;
  final String title;
  final Widget body;

  MainLayout({this.isShop, this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO waiting for this: https://github.com/joostlek/GradientAppBar/pulls pull request to merge and support shapes
      // until then i just copied the code, fixed it and added it as widget
      appBar: GradientAppBar(
        // leading: Icon(
        //   Icons.arrow_back,
        //   color: Colors.white,
        // ),
        shape: AppBarShapeBorder(),
        title: Text(
          title,
          textAlign: TextAlign.end,
          style: TextStyles.body_text_white,
        ),
        gradient: isShop
            ? GradientStyles.shopWalletAppbarGradient
            : GradientStyles.privateWalletAppbarGradient,
        elevation: 0,
      ),
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
    final double extraHeight = 15.0;
    final double stepWidth = 20.0;

    Path path = Path();
    path.lineTo(0, rect.height + extraHeight);
    path.lineTo(50.0, rect.height + extraHeight);
    path.lineTo(50.0 + stepWidth, rect.height);
    path.lineTo(rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}
