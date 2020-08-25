import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class VerificationFormUid extends StatelessWidget {
  final UidVerificationInput model;

  const VerificationFormUid({Key key, this.model}) : super(key: key);

  Widget _numberInput(BuildContext context, Function(String) onChanged) {
    return SizedBox.fromSize(
      child: TextFormField(
        onChanged: onChanged,
        maxLength: 3,
        enableInteractiveSelection: false,
        maxLengthEnforced: true,
        enabled: !model.hasUid,
        textAlign: TextAlign.end,
        style: Theme.of(context)
            .textTheme
            .headline4
            .merge(TextStyle(color: ColorStyles.black)),
        keyboardType: TextInputType.number,
        decoration: _decoration(context, ''),
      ),
      size: Size.fromWidth(60),
    );
  }

  Widget _numberDotText(BuildContext context) {
    return Text(
      '.',
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .merge(TextStyle(color: ColorStyles.black)),
    );
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'CHE-',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .merge(TextStyle(color: ColorStyles.black)),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _numberInput(context, model.part1Changed),
                    _numberDotText(context),
                    _numberInput(context, model.part2Changed),
                    _numberDotText(context),
                    _numberInput(context, model.part3Changed),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 16,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Checkbox(
              visualDensity: VisualDensity(),
              activeColor: ColorStyles.bg_gray,
              onChanged: model.hasUidChanged,
              value: model.hasUid,
            ),
            Text(
              I18n.of(context).verificationShopFormUidNoUid,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        )
      ],
    );
  }

  InputDecoration _decoration(BuildContext context, String label) {
    return InputDecoration(
        hintText: label,
        labelText: label,
        fillColor: ColorStyles.bg_gray,
        focusColor: ColorStyles.black,
        counterText: '',
        labelStyle: Theme.of(context)
            .textTheme
            .headline4
            .merge(TextStyle(color: ColorStyles.black)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorStyles.black)));
  }
}
