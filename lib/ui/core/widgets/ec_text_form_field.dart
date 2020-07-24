import 'package:flutter/material.dart';

class ECTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) validator;
  final TextEditingController controller;

  ECTextFormField({this.label, this.hint, this.validator, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headline3,
            helperText: label,
            helperStyle: Theme.of(context).textTheme.bodyText2));
  }
}
