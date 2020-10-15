import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NoServiceInfoScreen extends StatelessWidget {
  final IRouter _router;

  NoServiceInfoScreen(this._router);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              SingleChildScrollView(
                child: OnboardingPageWidget(
                  title: '',
                  headline: I18n.of(context).noServiceScreenTitle,
                  description: I18n.of(context).noServiceScreenDescription,
                  headerIconAsset: Assets.icon_arrow_right_svg,
                  headerIconBackgroundAsset:
                      Assets.onboarding_background_graphic_shop_svg,
                  bottomInset: 50,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(
                    bottom: 70,
                    left: LayoutStyles.spacing_m,
                    right: LayoutStyles.spacing_m),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: OutlinedSecondaryButton(
                    svgAsset: Assets.icon_leaf_svg,
                    text: I18n.of(context).noServiceScreenButton,
                    textColor: ColorStyles.black,
                    outlineColor: ColorStyles.bg_gray,
                    onPressed: () async {
                      await _router.pushAndRemoveUntil(SplashRoute, '');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
