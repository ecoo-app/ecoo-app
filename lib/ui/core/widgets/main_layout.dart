import 'package:e_coupon/ui/core/style/gradient.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class MainLayout extends StatelessWidget {
  final title;
  final body;

  MainLayout({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // waiting for this: https://github.com/joostlek/GradientAppBar/pulls pull request to merge and support shapes
      appBar: GradientAppBar(
        shape: AppBarShapeBorder(),
        //title: title,
        title: Text(
          'text',
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white),
        ),
        // gradient: ThemeGradients.defaultGradient,
        gradient: Gradients.cosmicFusion,
        elevation: 0,
      ),
      body: body,
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
    // path.cubicTo(
    //     rect.width / 1.5 - 40,
    //     rect.height + innerCircleRadius - 40,
    //     rect.width / 1.5 + 40,
    //     rect.height + innerCircleRadius - 40,
    //     rect.width / 1.5 + 75,
    //     rect.height + 50);
    // path.quadraticBezierTo(rect.width / 1.5 + (innerCircleRadius / 2) + 30,
    //     rect.height + 35, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}
