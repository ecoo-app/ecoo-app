import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/flat_secondary_button.dart';
import 'package:e_coupon/ui/screens/register/register_scaffold.dart';
import 'package:e_coupon/ui/screens/register/register_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'dart:io' show Platform;

@injectable
class RegisterScreen extends StatelessWidget {
  final RegisterScreenViewModel viewModel;

  RegisterScreen(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return RegisterScaffold(
        title: I18n.of(context).titleRegisterScreen,
        subhead: Text(
          I18n.of(context).descriptionRegisterScreen,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            FutureBuilder(
              future: viewModel.isAppleAvailable(),
              builder: (context, snapshot) {
                if (snapshot.hasData && !Platform.isAndroid) {
                  if (!snapshot.data) {
                    return Container();
                  }
                  return RegisterButton(
                    text: I18n.of(context).signinwithappleRegisterScreen,
                    svgAsset: Assets.apple_icon_svg,
                    onTap: snapshot.data ? viewModel.registerWithApple : null,
                    brightness: Brightness.dark,
                  );
                }
                return Container();
              },
            ),
            SizedBox(
              height: 30,
            ),
            RegisterButton(
              brightness: Brightness.light,
              text: I18n.of(context).signinwithgoogleRegisterScreen,
              onTap: viewModel.registerWithGoogle,
              svgAsset: Assets.google_icon_svg,
            ),
          ],
        ),
        footer: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 25.0),
          child: FlatSecondaryButton(
            text: I18n.of(context).onboardingRegisterScreen,
            textColor: ColorStyles.purple,
            onPressed: viewModel.onboarding,
          ),
        ));
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String svgAsset;
  final Brightness brightness;

  const RegisterButton({
    Key key,
    @required this.onTap,
    @required this.text,
    @required this.svgAsset,
    @required this.brightness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
    var borderSide = BorderSide(
      color: ColorStyles.black,
      style: BorderStyle.solid,
      width: 0.5,
    );
    var decoration = BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(10));

    var textColor = ColorStyles.white;

    if (brightness == Brightness.light) {
      borderSide = BorderSide(
        color: ColorStyles.brown_gray,
        style: BorderStyle.solid,
        width: 0.5,
      );
      decoration = BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ColorStyles.brown_gray,
              width: 0.5,
              style: BorderStyle.solid));
      textColor = ColorStyles.black;
    }

    return DecoratedBox(
      decoration: decoration,
      child: OutlineButton(
        padding: const EdgeInsets.symmetric(vertical: 23),
        color: brightness == Brightness.light
            ? ColorStyles.white
            : ColorStyles.black,
        onPressed: onTap,
        borderSide: borderSide,
        highlightedBorderColor: ColorStyles.black,
        shape: border,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            svgAsset == null ? Container() : SvgPicture.asset(svgAsset),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .merge(TextStyle(color: textColor)),
            ),
          ],
        ),
      ),
    );
  }
}
