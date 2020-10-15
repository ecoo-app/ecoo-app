import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WalletCard extends StatelessWidget {
  final IWalletEntity wallet;
  final bool isActive;
  final onPressed;

  WalletCard({this.wallet, this.onPressed, Key key, this.isActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        color: ColorStyles.bg_light_gray,
        borderRadius: BorderRadius.circular(4.0),
        border: isActive
            ? Border.all(
                width: 1.5,
                color: wallet.isShop ? ColorStyles.blue : ColorStyles.green)
            : null);

    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(wallet.id,
                                style: Theme.of(context).textTheme.headline3),
                            Text(I18n.of(context).walletMenuScreen,
                                style: Theme.of(context).textTheme.bodyText2)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 73,
                      width: 95,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            top: -100,
                            right: -75,
                            child: SvgPicture.asset(
                              wallet.isShop
                                  ? Assets.wallet_rectangle_blue_svg
                                  : Assets.wallet_rectangle_green_svg,
                              fit: BoxFit.none,
                              allowDrawingOutsideViewBox: false,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.only(right: 18, top: 20),
                            child: SvgPicture.asset(
                                wallet.isShop
                                    ? Assets.wallet_shop_svg
                                    : Assets.wallet_private_svg,
                                color: ColorStyles.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(wallet.currency.label,
                        style: Theme.of(context).textTheme.bodyText2),
                    Text(
                      wallet.toBalanceCurrencyLabel(),
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
