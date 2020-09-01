import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ValidationFunction = bool Function();

class VerificationFormField extends StatelessWidget {
  final TextVerificationInput model;
  final String label;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const VerificationFormField(
      {Key key,
      @required this.model,
      this.label,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: model.setValue,
      onFieldSubmitted: (String value) => model.fieldFocusChange(context),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: model.focusNode,
      autocorrect: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: label,
          fillColor: ColorStyles.bg_gray,
          focusColor: ColorStyles.black,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText2
              .merge(TextStyle(color: ColorStyles.bg_gray)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorStyles.black))),
      validator: (value) {
        var result = model.isValid;
        if (result) {
          return null;
        } else {
          return I18n.of(context).formErrorRequired;
        }
      },
    );
  }
}
