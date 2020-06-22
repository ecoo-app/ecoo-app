import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/screens/payment/payment_screen.dart';
import 'package:e_coupon/ui/screens/wallets/wallet_screen.dart';
import 'package:e_coupon/ui/shared/icon_button.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:flutter/material.dart';

import 'wallet_layout.dart';

class WalletState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    // return new PaymentScreen();
    return new WalletLayout(
        title: new Text('my wallet'),
        body: new Column(
          children: <Widget>[
            new Center(
                child: new CustomIconButton(
              icon: Icons.face,
              text: I18n.of(context).buttonTabMe,
              onPressed: () {
                print("Tapped Me");
              },
            )),
            new PrimaryButton(
              text: 'gradient',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()),
                );
              },
            )
            //new Row(children: <Widget>[new PrimaryButton(text: 'gradient')])
          ],
        ));
  }
}
