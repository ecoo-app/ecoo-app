import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/screens/payment/success_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../injection.dart';

class SuccessScreenArguments {
  final bool isShop;
  final String text;
  final String iconAssetPath;
  final String nextRoute;
  SuccessScreenArguments({
    @required this.isShop,
    @required this.text,
    @required this.iconAssetPath,
    this.nextRoute,
  });
}

class SuccessScreen extends StatelessWidget {
  final SuccessScreenArguments args;

  SuccessScreen(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BaseView<SuccessViewModel>(
            model: getIt<SuccessViewModel>(),
            onModelReady: (vmodel) => vmodel.init(args.nextRoute),
            builder:
                (BuildContext context, SuccessViewModel vmodel, Widget child) {
              return Center(
                  child: Container(
                decoration: BoxDecoration(
                    gradient: args.isShop
                        ? GradientStyles.shopWalletBackgroundGradient
                        : GradientStyles.privateWalletBackgroundGradient),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      args.iconAssetPath != null
                          ? SvgPicture.asset(
                              args.iconAssetPath,
                              color: Colors.white,
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 29,
                      ),
                      Text(args.text ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .merge(TextStyle(color: ColorStyles.white)))
                    ],
                  ),
                ),
              ));
            }));
  }
}
