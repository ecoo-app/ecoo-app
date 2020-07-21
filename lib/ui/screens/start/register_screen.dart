import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:e_coupon/ui/screens/start/register_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterScreen extends StatelessWidget {
  final RegisterScreenViewModel viewModel;

  RegisterScreen(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BaseView<RegisterScreenViewModel>(
          model: viewModel,
          builder: (context, model, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomHeader(
                  closeIcon: Assets.close_svg,
                  onClose: model.close,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 90),
                          Text(I18n.of(context).titleRegisterScreen,
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(height: 2),
                          Text(
                            I18n.of(context).descriptionRegisterScreen,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 60,
                                ),
                                RegisterButton(
                                  text: I18n.of(context)
                                      .signinwithappleRegisterScreen,
                                  svgAsset: Assets.apple_icon_svg,
                                  onTap: model.registerWithApple,
                                  brightness: Brightness.dark,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                RegisterButton(
                                  brightness: Brightness.light,
                                  text: I18n.of(context)
                                      .signinwithgoogleRegisterScreen,
                                  onTap: model.registerWithGoogle,
                                  svgAsset: Assets.google_icon_svg,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
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
    var decoration = BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(10));
    var textColor = ColorStyles.white;
    if (brightness == Brightness.light) {
      decoration = BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ColorStyles.brown_gray,
              width: 0.5,
              style: BorderStyle.solid));
      textColor = ColorStyles.black;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        decoration: decoration,
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
