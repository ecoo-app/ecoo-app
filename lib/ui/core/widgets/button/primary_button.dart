import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final EdgeInsets margin;
  final bool isEnabled;

  PrimaryButton(
      {this.onPressed,
      @required this.text,
      this.isEnabled = true,
      this.isLoading = false,
      this.margin});

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [
            0.0,
            0.49,
            1.0,
            1.0,
          ],
          colors: [
            ColorStyles.pink,
            Color(0xFFC971FF),
            ColorStyles.purple,
            ColorStyles.purple
          ],
        ),
        color: Colors.black,
        borderRadius: BorderRadius.circular(10));

    var border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));

    var textColor = isEnabled ? ColorStyles.bg_light_gray : ColorStyles.white;
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      child: DecoratedBox(
        decoration: decoration,
        child: OutlineButton(
          padding: const EdgeInsets.symmetric(vertical: 15),
          onPressed: (isLoading || !isEnabled) ? null : onPressed,
          shape: border,
          borderSide: BorderSide.none,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isLoading
                  ? ECProgressIndicator()
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .merge(TextStyle(color: textColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
