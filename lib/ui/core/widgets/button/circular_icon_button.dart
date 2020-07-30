import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;
  final String text;

  CircularIconButton(
      {@required this.onPressed, @required this.icon, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RawMaterialButton(
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: Colors.white,
        child: Icon(
          icon,
          // size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
      Padding(padding: const EdgeInsets.only(top: 8)),
      Text(text)
    ]);
  }
}
