import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/widgets/button/rhombus_button.dart';
import 'package:e_coupon/ui/core/widgets/layout/headerless_layout.dart';
import 'package:flutter/material.dart';

class WalletCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HeaderlessLayout(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Wallet typ',
            ),
            Text(
                'Polaroid raw denim fingerstache lumbersexual street art kale chips cornhole before they sold out. Wolf VHS shabby chic asymmetrical intelligentsia blue bottle scenester edison bulb 8-bit. Typewriter neutra prism, raclette glossier chartreuse adaptogen food truck jianbing blog craft beer waistcoat paleo. Scenester iceland butcher brunch put a bird on it raw denim taiyaki selfies squid. Seitan bicycle rights man braid fixie truffaut chicharrones cray, vaporware gochujang'),
            RhombusButton(
              text: 'private',
              onPressed: () =>
                  Navigator.pushNamed(context, ClaimVerificationRoute),
            ),
            RhombusButton(
              text: 'shop',
              onPressed: () =>
                  Navigator.pushNamed(context, ClaimVerificationRoute),
            )
          ],
        ),
      ),
    );
  }
}
