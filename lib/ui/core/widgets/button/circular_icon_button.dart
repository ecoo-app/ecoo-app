import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircularIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String iconAsset;
  final String text;

  CircularIconButton(
      {@required this.onPressed,
      @required this.iconAsset,
      @required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RawMaterialButton(
        constraints: BoxConstraints(
            minHeight: 70, maxHeight: 70, minWidth: 70, maxWidth: 70),
        onPressed: onPressed,
        elevation: 0,
        fillColor: ColorStyles.bg_light_gray,
        child: SvgPicture.asset(iconAsset),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
      Padding(padding: const EdgeInsets.only(top: 8)),
      Text(text)
    ]);
  }
}
