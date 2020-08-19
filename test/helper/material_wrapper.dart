import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MaterialWrapper {
  static Widget wrap(Widget widget) {
    return MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    );
  }
}
