import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddWalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: FlatButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, WalletSelectionRoute);
        },
        icon: Icon(Icons.add_circle_outline),
        label: Text(I18n.of(context).addWallet),
      ),
    );
  }
}
