import 'package:flutter/widgets.dart';

class RhombusShapeBorder extends RoundedRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final double step = 50.0;
    final radius = 5;

    Path path = Path();
    path.moveTo(0, step);
    path.lineTo(step - radius, rect.height - radius);
    path.quadraticBezierTo(
        step, rect.height, step + radius, rect.height - radius);
    path.lineTo(rect.width, rect.height - step);
    path.lineTo(rect.width - step, 0);
    path.close();

    // path.cubicTo(
    //     rect.width / 1.5 - 40,
    //     rect.height + innerCircleRadius - 40,
    //     rect.width / 1.5 + 40,
    //     rect.height + innerCircleRadius - 40,
    //     rect.width / 1.5 + 75,
    //     rect.height + 50);
    // path.quadraticBezierTo(rect.width / 1.5 + (innerCircleRadius / 2) + 30,
    //     rect.height + 35, rect.width, rect.height);

    return path;
  }
}
