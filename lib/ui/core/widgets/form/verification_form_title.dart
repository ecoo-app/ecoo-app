import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerificationFormTitle extends StatelessWidget {
  final String text;

  const VerificationFormTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 27),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}
