import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderlessLayout extends StatelessWidget {
  /// default is back icon
  final IconData titleIcon;
  final String title;
  final Widget body;

  HeaderlessLayout({this.titleIcon, this.title, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(titleIcon),
        title: title != null ? Text(title) : Text(''),
        backgroundColor: Colors.white,
      ),
      body: Container(
          margin: const EdgeInsets.only(left: 24, right: 24, top: 36),
          child: body),
    );
  }
}
