import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter/widgets.dart';

class ThemeGradients extends Gradients {
  static final AlignmentGeometry _beginAlignment = Alignment.topLeft;
  static final AlignmentGeometry _endAlignment = Alignment.bottomRight;

  // static LinearGradient defaultGradient = Gradients.buildGradient(
  //     _beginAlignment,
  //     _endAlignment,
  //     const [Color(0xffFFF0D1), Color(0xffFFB8C6)]);

  static LinearGradient defaultGradient = Gradients.buildGradient(
      _beginAlignment,
      _endAlignment,
      const [Color(0xff7dff7b), Color(0xff03cf80)]);
}
