import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AmountDisplay extends StatelessWidget {
  final bool isLoading;
  final String amount;
  final String symbol;
  final bool isShopColor;
  final bool hasConnection;

  AmountDisplay(
      {this.isLoading,
      this.amount,
      this.symbol,
      this.isShopColor,
      this.hasConnection});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        isShopColor
            ? SvgPicture.asset(
                Assets.shop_header_svg,
              )
            : SvgPicture.asset(
                Assets.private_header_svg,
              ),
        Container(
          margin: const EdgeInsets.only(right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '$amount',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .merge(TextStyle(color: ColorStyles.white)),
                textAlign: TextAlign.end,
              ),
              Text(
                '$symbol',
                style: Theme.of(context).textTheme.headline5.merge(TextStyle(
                    height: 0.6,
                    fontWeight: fontWeightRegular,
                    color: ColorStyles.white)),
                textAlign: TextAlign.end,
              )
            ],
          ),
        ),
      ],
    );
  }
}
