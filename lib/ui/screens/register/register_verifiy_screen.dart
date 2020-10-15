import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/flat_secondary_button.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/screens/register/register_scaffold.dart';
import 'package:e_coupon/ui/screens/register/register_verify_screen_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class RegisterVerifyScreen extends StatelessWidget {
  final RegisterVerifyScreenViewModel viewModel;

  const RegisterVerifyScreen(this.viewModel);

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    var description = I18n.of(context).descriptionRegisterVerifyScreenPrivate;
    var title = I18n.of(context).titleRegisterVerifyScreenPrivate;
    if (viewModel.isShop) {
      description = I18n.of(context).descriptionRegisterVerifyScreenShop;
      title = I18n.of(context).titleRegisterVerifyScreenShop;
    }

    return RegisterScaffold(
      title: title,
      subhead: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: description,
              style: Theme.of(context).textTheme.bodyText2,
              // textAlign: TextAlign.center,
            ),
            TextSpan(
              text: I18n.of(context).descriptionRegisterVerifyScreenLink,
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launchUrl(
                    I18n.of(context).descriptionRegisterVerifyScreenLink),
              style: Theme.of(context).textTheme.bodyText2.merge(
                    TextStyle(color: ColorStyles.purple),
                  ),
            ),
          ],
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .merge(TextStyle(color: ColorStyles.bg_gray)),
        ),
      ),
      // subhead: Column(
      //   children: [
      //     Text(
      //       description,
      //       style: Theme.of(context).textTheme.bodyText2,
      //       textAlign: TextAlign.center,
      //     ),
      //     TextSpan(
      //             text: "https://www.wetzikon.ch/ecoupon",
      //             recognizer: TapGestureRecognizer()
      //               ..onTap = () => _launchUrl(
      //                                       I18n.of(context).descriptionRegisterVerifyScreenLink),
      //                                 style: Theme.of(context)
      //                                     .textTheme
      //                                     .bodyText2
      //                                     .merge(TextStyle(color: ColorStyles.purple),),
      //                               ),
      //                       ],
      //                     ),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: PrimaryButton(
              text: I18n.of(context).verifyButtonRegisterVerifyScreen,
              onPressed: viewModel.verify,
            ),
          ),
          FlatSecondaryButton(
            textColor: ColorStyles.red,
            onPressed: viewModel.verifyLater,
            text: I18n.of(context).verifyLaterButtonRegisterVerifyScreen,
          )
        ],
      ),
    );
  }
}
