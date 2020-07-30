import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class OutlinedSecondaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final Color textColor;
  final String svgAsset;

  OutlinedSecondaryButton({
    this.onPressed,
    @required this.text,
    this.textColor,
    this.svgAsset,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      padding: const EdgeInsets.symmetric(vertical: 20),
      onPressed: onPressed,
      color: ColorStyles.bg_white_9,
      highlightedBorderColor: ColorStyles.bg_gray,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
    );
  }
}
