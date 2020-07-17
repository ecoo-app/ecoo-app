import 'package:flutter/material.dart';

class FlatIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onPressed;

  FlatIconButton(
      {@required this.icon, @required this.label, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
