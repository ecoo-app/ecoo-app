import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final title;
  final body;

  PaymentScreen({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return new MainLayout(title: new Text('payment'), body: new Text('body'));
  }
}
