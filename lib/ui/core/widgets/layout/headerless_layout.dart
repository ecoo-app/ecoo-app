import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuLayout extends StatelessWidget {
  /// default is back icon
  final IconData titleIcon;
  final String title;
  final Widget body;

  MenuLayout({this.titleIcon, this.title, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(titleIcon),
          title: Text(title),
        ),
        body: body);
  }
}
