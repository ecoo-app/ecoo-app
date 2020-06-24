import 'package:e_coupon/ui/screens/wallet_screens/wallets_overview/wallets_overview.dart';
import 'package:flutter/material.dart';

class WalletLayout extends StatelessWidget {
  final title;
  final body;

  WalletLayout({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'wallets overview',
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletsOverview()),
              );
            },
          ),
          title: title,
          backgroundColor: Colors.cyan,
        ),
        body: body);
  }
}
