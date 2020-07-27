import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/screens/start/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashScreen extends StatelessWidget {
  final SplashScreenViewModel viewModel;

  const SplashScreen(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<SplashScreenViewModel>(
        model: viewModel,
        onModelReady: (e) => viewModel.startup(),
        builder: (context, model, child) {
          return SafeArea(
            top: false,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned.fill(
                  top: -70,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      Assets.splash_wallet_graphic_svg,
                      fit: BoxFit.none,
                    ),
                  ),
                ),
                Center(
                  child: Text(I18n.of(context).titleSplashScreen,
                      style: TextStyle(
                          color: ColorStyles.black,
                          fontSize: 50.0,
                          fontFamily: fontFamiliyPanam,
                          fontWeight: fontWeightBold)),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Powered by',
                          style: TextStyle(
                              color: ColorStyles.brown_gray,
                              fontSize: 12,
                              fontWeight: fontWeightRegular,
                              letterSpacing: 0.0)),
                      SizedBox(
                        height: 15,
                      ),
                      SvgPicture.asset(
                        Assets.tezos_svg,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Tezos',
                        style: TextStyle(
                            color: ColorStyles.bg_gray,
                            fontWeight: fontWeightMedium,
                            fontSize: 25.0,
                            letterSpacing: 0.0),
                      ),
                      SizedBox(
                        height: 37,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
