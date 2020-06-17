import 'package:flutter/material.dart';

class WalletLayout extends StatelessWidget{
  final title;
  final body;

  WalletLayout(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: title,
      ),
      body: body
    );
  }
}