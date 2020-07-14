import 'package:flutter/material.dart';

class MenuLayout extends StatelessWidget {
  final title;
  final body;

  MenuLayout(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Meine Wallets'),
        ),
        body: body);
  }
}
