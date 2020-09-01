import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef ValidationFunction = bool Function();

class VerificationFormPhoneField extends StatelessWidget {
  final PhoneNumberVerificationInput model;
  final String label;
  final TextInputType keyboardType;

  const VerificationFormPhoneField(
      {Key key,
      @required this.model,
      this.label,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: model.setValue,
      onFieldSubmitted: (String value) => model.fieldFocusChange(context),
      focusNode: model.focusNode,
      autocorrect: false,
      maxLength: 12,
      maxLengthEnforced: true,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        PhoneNumberInputFormatter()
      ],
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: label,
          labelText: label,
          fillColor: ColorStyles.bg_gray,
          focusColor: ColorStyles.black,
          suffixIcon: const Icon(
            Icons.phone,
            color: ColorStyles.bg_gray,
          ),
          counterText: '',
          prefixText: '+41 ',
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

/// Format incoming numeric text to fit the format of ## ### ## ##
class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;

    final StringBuffer newText = StringBuffer();

    final firstIndex = 3;
    final secondIndex = 6;
    final thirdIndex = 8;

    if (newTextLength >= firstIndex) {
      newText.write(
          newValue.text.substring(0, usedSubstringIndex = firstIndex - 1) +
              ' ');
      if (newValue.selection.end >= firstIndex - 1) selectionIndex++;
    }

    if (newTextLength >= secondIndex) {
      newText.write(newValue.text
              .substring(firstIndex - 1, usedSubstringIndex = secondIndex - 1) +
          ' ');
      if (newValue.selection.end >= secondIndex - 1) selectionIndex++;
    }

    if (newTextLength >= thirdIndex) {
      newText.write(newValue.text
              .substring(secondIndex - 1, usedSubstringIndex = thirdIndex - 1) +
          ' ');
      if (newValue.selection.end >= thirdIndex - 1) selectionIndex++;
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
