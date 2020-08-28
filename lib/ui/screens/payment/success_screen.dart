import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/screens/payment/success_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';

import '../../../injection.dart';

class SuccessScreenArguments {
  final bool isShop;
  final String text;
  final String iconAssetPath;
  final String nextRoute;
  SuccessScreenArguments({
    this.isShop,
    this.text,
    this.iconAssetPath,
    this.nextRoute,
  });
}

class SuccessScreen extends StatelessWidget {
  final SuccessScreenArguments args;

  SuccessScreen(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BaseView<SuccessViewModel>(
          model: getIt<SuccessViewModel>(),
          onModelReady: (vmodel) => vmodel.init(),
          builder: (_, vmodel, __) {
            if (vmodel.viewState is DurationEnd) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                // Navigator.of(context)
                //     .popUntil(ModalRoute.withName(WalletDetailRoute));
                // TODO which is correct?
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(args.nextRoute, (_) => false);
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     WalletDetailRoute,
                //     ModalRoute.withName(WalletDetailRoute));
                // Navigator.pushNamed(context, WalletDetailRoute);
              });
            }
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
                    SvgPicture.asset(
                      args.iconAssetPath,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 29,
                    ),
                    Text(
                      args.text,
                      style: TextStyles.headline3_text_white,
                    )
                  ],
                ),
              ),
            ));
          }),
    ));
  }
}
