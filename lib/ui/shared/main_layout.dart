import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final title;
  final body;

  MainLayout(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: title,
      ),
      body: body,
    );
  }
}
