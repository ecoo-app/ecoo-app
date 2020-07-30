import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class RhombusIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final double size = 66;

  RhombusIconButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 24, left: 4, right: 4),
      child: Container(
        width: size,
        height: size,
        child: GestureDetector(
          onTap: onPressed,
          child: SvgPicture.asset(Assets.icon_button_svg),
        ),
      ),
    );
  }
}
