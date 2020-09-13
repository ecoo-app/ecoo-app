import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';

class ECTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) validator;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final TextInputType keyboardType;
  final int maxLength;

  ECTextFormField(
      {this.label,
      this.hint,
      this.validator,
      this.controller,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforced: maxLength != null,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .headline3
            .merge(TextStyle(fontWeight: fontWeightRegular)),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headline3,
            helperText: label,
            helperStyle: Theme.of(context).textTheme.bodyText2));
  }
}
