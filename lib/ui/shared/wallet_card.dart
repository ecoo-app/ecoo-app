import 'package:e_coupon/business/entities/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;
  final onPressed;

  WalletCard({this.wallet, this.onPressed, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              // other clickable widget: InkWell: use as child of card
              onTap: onPressed,
              leading: Icon(Icons.account_balance_wallet),
              title: Text(wallet.id),
              subtitle: Text(wallet.currency.label),
            ),
          ],
        ),
      ),
    );
  }
}
