import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class RhombusButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final colorTheme;
  final bool isLoading;
  final double size;

  RhombusButton(
      {this.onPressed,
      @required this.text,
      this.colorTheme,
      this.isLoading = false,
      this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 24, left: 4, right: 4),
      // TODO
      child: Container(
        width: size,
        height: size,
        child: GradientButton(
          increaseHeightBy: double.infinity,
          increaseWidthBy: double.infinity,
          gradient: Gradients.coldLinear,
          shape: RhombusShapeBorder(),
          // gradient: ThemeGradients.defaultGradient,
          callback: onPressed,
          shapeRadius: BorderRadius.all(Radius.circular(10)),
          child: isLoading
              ? Row(
                  children: <Widget>[
                    CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white)),
                    Text(text)
                  ],
                )
              : Text(
                  text,
                ),
          elevation: 0,
        ),
      ),
    );
  }
}

// rotate something for some degrees: https://stackoverflow.com/questions/44276080/how-do-i-rotate-something-15-degrees-in-flutter
// RotationTransition(
//   turns: new AlwaysStoppedAnimation(15 / 360),
//   child: new Text("Lorem ipsum"),
// )

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
