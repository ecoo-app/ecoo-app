import 'package:e_coupon/ui/localization/localization.dart';
import 'package:e_coupon/ui/screens/wallets/wallet_screen.dart';
import 'package:e_coupon/ui/shared/icon_button.dart';
import 'package:flutter/material.dart';

import 'wallet_layout.dart';

class WalletState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return new WalletLayout(
      new Text('my wallet'),
      new Center(
          child: new CustomIconButton(
        icon: Icons.face,
        text: getTranslated(context, 'button.tab_me'),
        onPressed: () {
          print("Tapped Me");
        },
      )),
    );
  }
}
