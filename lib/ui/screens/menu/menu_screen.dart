import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget{
  final title;
  final body;

  MenuScreen(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Meine Wallets'),
      ),
      body: body
    );
  }
}