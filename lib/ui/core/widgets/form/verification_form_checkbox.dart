import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class VerificationFormCheckBox extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;

  final String textPartStart;
  final String textUrlPart;
  final String textPartEnd;

  VerificationFormCheckBox({
    Key key,
    @required this.value,
    @required this.onChanged,
    @required this.textPartStart,
    @required this.textUrlPart,
    @required this.textPartEnd,
  }) : super(key: key);

  @override
  _VerificationFormCheckBoxState createState() =>
      _VerificationFormCheckBoxState();
}

class _VerificationFormCheckBoxState extends State<VerificationFormCheckBox> {
  final TapGestureRecognizer onTextTapped = TapGestureRecognizer();

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _onChange(bool value) {
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    onTextTapped.onTap = () => _onChange(!widget.value);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Checkbox(
          visualDensity: VisualDensity(),
          activeColor: ColorStyles.bg_gray,
          onChanged: widget.onChanged,
          value: widget.value,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.textPartStart,
                  recognizer: onTextTapped,
                ),
                TextSpan(
                  text: widget.textUrlPart,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchUrl(
                        I18n.of(context).verificationFilledTruthfullyTosUrl),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: ColorStyles.purple),),
                ),
                TextSpan(
                  text: widget.textPartEnd,
                ),
              ],
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .merge(TextStyle(color: ColorStyles.bg_gray)),
            ),
          ),
        ),
      ],
    );
  }
}
