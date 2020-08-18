import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerificationFormCheckBox extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool) onChanged;

  const VerificationFormCheckBox(
      {Key key, this.text, this.value, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Checkbox(
          visualDensity: VisualDensity(),
          activeColor: ColorStyles.bg_gray,
          onChanged: onChanged,
          value: value,
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .merge(TextStyle(color: ColorStyles.bg_gray)),
          ),
        ),
      ],
    );
  }
}
