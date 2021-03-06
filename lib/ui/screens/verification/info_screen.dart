import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class VerificationInfoScreenArguments {
  final String headline;
  final String description;

  VerificationInfoScreenArguments(this.headline, this.description);
}

@injectable
class VerificationInfoScreen extends StatelessWidget {
  final IRouter _router;

  VerificationInfoScreen(this._router);

  @override
  Widget build(BuildContext context) {
    VerificationInfoScreenArguments arguments = ModalRoute.of(context)
        .settings
        .arguments as VerificationInfoScreenArguments;

    assert(
        arguments != null &&
            arguments.description != null &&
            arguments.headline != null,
        'Set InfoScreenArguments');

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
                  title: I18n.of(context).verifyNoUidTitle,
                  headline: arguments.headline,
                  description: arguments.description,
                  headerIconAsset: Assets.shipping_fast_svg,
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
