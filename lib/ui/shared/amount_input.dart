import 'package:flutter/material.dart';

class AmountInputField extends StatelessWidget {
  final TextEditingController controller;

  AmountInputField({this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.headline1,
            // style: TextStyle(fontSize: 75),
            textAlign: TextAlign.end,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Betrag'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onEditingComplete: () => print('amount editing complete'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Uups, der Betrag ist vergessen gegangen.';
              }
              return null;
            },
          ),
          Text(
            'CHF',
            textAlign: TextAlign.end,
          )
        ]);
  }
}
