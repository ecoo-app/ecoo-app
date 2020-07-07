import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:flutter/cupertino.dart';

class PaymentOverviewArguments extends Transaction {
  final String title;
  PaymentOverviewArguments(
      {this.title, String senderId, String recieverId, double amount})
      : super(senderId: senderId, recieverId: recieverId, amount: amount);
}

class PaymentOverviewScreen extends StatelessWidget {
  final PaymentOverviewArguments arguments;

  PaymentOverviewScreen({@required this.arguments});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: Text('Geld senden'),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              '${arguments.amount} CHF',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Text(
              'senden an ${arguments.recieverId}',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            PrimaryButton(
              text: I18n.of(context).personalWalletPay,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  WalletDetailRoute,
                );
              },
            ),
          ],
        ),
        padding: const EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
