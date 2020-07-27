import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class ErrorScreen extends StatelessWidget {
  ErrorScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      decoration: BoxDecoration(gradient: GradientStyles.errorGradient),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CloseButton(
            color: Colors.white,
          ),
          Text(
            I18n.of(context).paymentFailed,
            style: TextStyles.headline3_text_white,
          ),
          Text(
            I18n.of(context).paymentFailedInfo,
            style: TextStyles.body_text_white,
          ),
          Text(I18n.of(context).iPay,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: fontWeightMedium,
                fontFamily: fontFamiliyPanam,
                color: ColorStyles.white,
              ))
        ],
      ),
    )));
  }
}
