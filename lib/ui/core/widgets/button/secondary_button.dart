import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final Icon icon;

  SecondaryButton({this.onPressed, @required this.text, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 24, left: 4, right: 4),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: OutlineButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(text),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}
