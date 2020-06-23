import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  // TODO finals: walletId, amount, name coins, privateOrShop
  WalletCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('BC25CDE45'),
              subtitle: Text('Steffisburg'),
            ),
          ],
        ),
      ),
    );
  }
}
