import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class InfoScreen extends StatelessWidget {
  final IRouter _router;

  InfoScreen(this._router);

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
              OnboardingPageWidget(
                title: I18n.of(context).verifyNoUidTitle,
                headline: '',
                description: I18n.of(context).verifyNoUidInfo,
                headerIconAsset: Assets.onboarding_icon_shop_arrows_svg,
                headerIconBackgroundAsset:
                    Assets.onboarding_background_graphic_shop_svg,
                bottomInset: 50,
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
                    svgAsset: Assets.icon_home_svg,
                    text: I18n.of(context).verifyNoUidButton,
                    textColor: ColorStyles.black,
                    outlineColor: ColorStyles.bg_gray,
                    onPressed: () async {
                      // TODO how to check if popUntil(WalletDetailRoute) is possible and otherwise use pushAndRemoveUntil:
                      // https://github.com/flutter/flutter/issues/48338
                      await _router.pushAndRemoveUntil(WalletDetailRoute, '');
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
