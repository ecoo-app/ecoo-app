import 'package:e_coupon/ui/core/widgets/button/rhombus_shape_border.dart';
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
                            AlwaysStoppedAnimation<Color>(Colors.white)),
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
