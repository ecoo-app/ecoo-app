import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';

class WalletLayout extends StatelessWidget {
  final title;
  final body;

  WalletLayout({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: getIt.get<MenuScreen>(),
        appBar: AppBar(
          elevation: 0,
          title: title,
          backgroundColor: Colors.cyan,
        ),
        body: SafeArea(
          bottom: true,
          child: Container(
              margin: const EdgeInsets.only(left: 24, right: 24), child: body),
        ));
  }
}
