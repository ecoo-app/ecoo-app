import 'package:e_coupon/generated/i18n.dart';
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
              I18n.of(context).titleWalletCreation,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              I18n.of(context).textWalletCreation,
              style: Theme.of(context).textTheme.bodyText2,
            ),
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
