import 'package:e_coupon/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

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
            textAlign: TextAlign.end,
            inputFormatters: [
              DecimalTextInputFormatter(decimalRange: 2),
            ],
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Betrag'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onEditingComplete: () => print('amount editing complete'),
            validator: (value) {
              if (value.isEmpty) {
                return I18n.of(context).validationAmountInput;
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

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter(
      {this.decimalRange, this.activatedNegativeValues = false})
      : assert(decimalRange == null || decimalRange >= 0,
            'DecimalTextInputFormatter declaretion error');

  final int decimalRange;
  final bool activatedNegativeValues;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (newValue.text.contains(' ')) {
      return oldValue;
    }

    if (newValue.text.isEmpty) {
      return newValue;
    } else if (double.tryParse(newValue.text) == null &&
        !(newValue.text.length == 1 &&
            (activatedNegativeValues == true ||
                activatedNegativeValues == null) &&
            newValue.text == '-')) {
      return oldValue;
    }

    if (activatedNegativeValues == false &&
        double.tryParse(newValue.text) < 0) {
      return oldValue;
    }

    if ((double.tryParse(oldValue.text) == 0 && !newValue.text.contains('.'))) {
      if (newValue.text.length >= oldValue.text.length) {
        return oldValue;
      }
    }

    if (decimalRange != null) {
      String value = newValue.text;

      if (decimalRange == 0 && value.contains(".")) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
