import 'package:e_coupon/ui/shared/wallet_card.dart';
import 'package:flutter/material.dart';

class WalletsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wallets'),
          backgroundColor: Colors.cyan,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 2,
          itemBuilder: (context, i) {
            return WalletCard();
          },
        ));
  }
}
