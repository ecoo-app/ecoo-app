import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
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
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 145),
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    Assets.splash_recangle_left_svg,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 0),
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    Assets.splash_recangle_top_svg,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 130),
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    Assets.splash_recangle_right_svg,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 150),
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    Assets.wallet_svg,
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Text('eCoupon',
                      style: Theme.of(context).textTheme.headline1),
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
