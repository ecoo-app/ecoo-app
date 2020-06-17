import 'package:e_coupon/generated/i18n.dart';
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
        text: I18n.of(context).buttonTabMe,
        onPressed: () {
          print("Tapped Me");
        },
      )),
    );
  }
}
