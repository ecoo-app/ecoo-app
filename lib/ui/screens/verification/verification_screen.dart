import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:flutter/cupertino.dart';

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: Text('Verification'),
      body: Column(children: <Widget>[
        Text('Inputs'),
      ]),
    );
  }
}
