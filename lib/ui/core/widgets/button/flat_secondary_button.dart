import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlatSecondaryButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const FlatSecondaryButton({
    Key key,
    @required this.text,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(
              color: textColor,
              fontWeight: fontWeightRegular,
            )),
      ),
      onPressed: onPressed,
    );
  }
}
