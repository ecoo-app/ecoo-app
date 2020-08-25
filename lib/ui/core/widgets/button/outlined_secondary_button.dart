import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class OutlinedSecondaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final Color textColor;
  final Color outlineColor;
  final String svgAsset;

  OutlinedSecondaryButton(
      {this.onPressed,
      @required this.text,
      this.textColor,
      this.outlineColor,
      this.svgAsset});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: ColorStyles.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ColorStyles.white.withOpacity(0.9),
              width: 0.5,
              style: BorderStyle.solid)),
      child: OutlineButton(
        padding: const EdgeInsets.symmetric(vertical: 20),
        onPressed: onPressed,
        highlightedBorderColor: ColorStyles.bg_gray,
        borderSide:
            outlineColor != null ? BorderSide(color: outlineColor) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            svgAsset == null ? SizedBox.shrink() : SvgPicture.asset(svgAsset),
            svgAsset == null
                ? SizedBox.shrink()
                : SizedBox(
                    width: 8,
                  ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .merge(TextStyle(color: textColor ?? ColorStyles.black)),
            ),
          ],
        ),
      ),
    );
  }
}
