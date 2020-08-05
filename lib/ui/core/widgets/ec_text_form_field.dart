import 'package:flutter/material.dart';

class ECTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) validator;
  final TextEditingController controller;
  final void Function(String) onChanged;

  ECTextFormField(
      {this.label, this.hint, this.validator, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headline3,
            helperText: label,
            helperStyle: Theme.of(context).textTheme.bodyText2));
  }
}
