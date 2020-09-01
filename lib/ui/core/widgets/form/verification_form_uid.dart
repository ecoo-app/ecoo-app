import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class VerificationFormUid extends StatefulWidget {
  final UidVerificationInput model;

  const VerificationFormUid({Key key, this.model}) : super(key: key);

  @override
  _VerificationFormUidState createState() => _VerificationFormUidState();
}

class _VerificationFormUidState extends State<VerificationFormUid> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onTextChanged);
  }

  void onTextChanged() {
    widget.model.setValue(controller.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 55,
          child: TextFormField(
            key: Key('uid-input'),
            controller: controller,
            focusNode: widget.model.focusNode,
            textInputAction: TextInputAction.next,
            maxLength: 11,
            enableInteractiveSelection: false,
            maxLengthEnforced: true,
            enabled: !widget.model.hasNoUid,
            enableSuggestions: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              UIDInputFormatter()
            ],
            style: Theme.of(context)
                .textTheme
                .headline4
                .merge(TextStyle(color: ColorStyles.black)),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: '000.000.000',
                isDense: true,
                fillColor: ColorStyles.bg_gray,
                focusColor: ColorStyles.black,
                counterText: '',
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                prefixIcon: Text(
                  'CHE-',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .merge(TextStyle(color: ColorStyles.black)),
                ),
                labelStyle: Theme.of(context)
                    .textTheme
                    .headline4
                    .merge(TextStyle(color: ColorStyles.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorStyles.black))),
          ),
        ),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
                text: I18n.of(context).verificationShopFormUidDescription,
                style: Theme.of(context).textTheme.bodyText2),
            TextSpan(
                text: I18n.of(context).verificationShopFormUidLink,
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      _launchUrl(I18n.of(context).verificationShopFormUidLink),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .merge(TextStyle(color: ColorStyles.purple)))
          ],
        )),
        SizedBox(height: 18),
        GestureDetector(
          onTap: () => _hasNoUidChanged(!widget.model.hasNoUid),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                focusNode: null,
                visualDensity: VisualDensity(),
                activeColor: ColorStyles.bg_gray,
                onChanged: (value) => _hasNoUidChanged(value),
                value: widget.model.hasNoUid,
              ),
              Text(
                I18n.of(context).verificationShopFormUidNoUid,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        )
      ],
    );
  }

  void _hasNoUidChanged(bool status) {
    widget.model.hasNoUidChanged(status);
    controller.text = widget.model.input;
  }
}

/// Format incoming numeric text to fit the format of ## ### ## ##
class UIDInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;

    final StringBuffer newText = StringBuffer();

    final firstIndex = 4;
    final secondIndex = 7;
    final thirdIndex = 10;
    final separator = '.';

    if (newTextLength >= firstIndex) {
      newText.write(
          newValue.text.substring(0, usedSubstringIndex = firstIndex - 1) +
              separator);
      if (newValue.selection.end >= firstIndex - 1) selectionIndex++;
    }

    if (newTextLength >= secondIndex) {
      newText.write(newValue.text
              .substring(firstIndex - 1, usedSubstringIndex = secondIndex - 1) +
          separator);
      if (newValue.selection.end >= secondIndex - 1) selectionIndex++;
    }

    if (newTextLength >= thirdIndex) {
      newText.write(newValue.text
              .substring(secondIndex - 1, usedSubstringIndex = thirdIndex - 1) +
          separator);
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
