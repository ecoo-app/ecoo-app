import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AmountDisplay extends StatelessWidget {
  final bool isLoading;
  final String amount;
  final String symbol;
  final bool isShopColor;

  AmountDisplay({this.isLoading, this.amount, this.symbol, this.isShopColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        Container(
          child: isShopColor
              ? SvgPicture.asset(Assets.shop_header_svg)
              : SvgPicture.asset(Assets.private_header_svg),
        ),
        Container(
          margin: EdgeInsets.only(right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '$amount',
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: fontWeightBold,
                    fontFamily: fontFamiliyPanam,
                    color: ColorStyles.white),
                textAlign: TextAlign.end,
              ),
              Text(
                '$symbol',
                style: TextStyle(
                    height: 0.6,
                    fontSize: 20.0,
                    fontWeight: fontWeightRegular,
                    fontFamily: fontFamiliyPanam,
                    color: ColorStyles.white),
                textAlign: TextAlign.end,
              )
            ],
          ),
        ),
      ],
    );
    // return Stack(
    //   alignment: AlignmentDirectional.center,
    //   children: <Widget>[
    //     ClipRect(
    //       child: Align(
    //         alignment: Alignment.topRight,
    //         child: Transform.rotate(
    //           angle: -13.0,
    //           child: Container(
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(40.0)),
    //                 gradient: GradientStyles.privateWalletBackgroundGradient),
    //             child: SizedBox(
    //               height: 280,
    //               width: 280,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Container(
    //       height: 180,
    //       child: Align(
    //         alignment: Alignment.center,
    //         child: Text(
    //           '$amount $symbol',
    //           style: Theme.of(context).textTheme.headline2,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    // return isLoading
    //     ? Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           ECProgressIndicator(),
    //           Text(
    //             '$amount $symbol',
    //             style: Theme.of(context).textTheme.headline2,
    //           )
    //         ],
    //       )
    //     : Center(
    //         child: Transform.rotate(
    //           angle: -13.0,
    //           child: Container(
    //             height: 180,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(40.0)),
    //                 gradient: GradientStyles.privateWalletBackgroundGradient),
    //             child: Align(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 '$amount $symbol',
    //                 style: Theme.of(context).textTheme.headline2,
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
  }
}
