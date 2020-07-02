import 'package:e_coupon/ui/core/router.dart';
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
              Navigator.pushNamed(
                context,
                WalletsOverviewRoute,
              );
            },
          ),
          title: title,
          backgroundColor: Colors.cyan,
        ),
        body: body);
  }
}
