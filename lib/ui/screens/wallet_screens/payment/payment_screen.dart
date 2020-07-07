import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view.dart';
import 'package:e_coupon/ui/core/router.dart';
import 'package:e_coupon/ui/screens/wallet_screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/wallet_screens/payment/transaction_view_model.dart';
import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../injection.dart';

class PaymentScreen extends StatelessWidget {
  final senderID;

  PaymentScreen({@required this.senderID});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: Text('scan'),
      body: BaseView<TransactionViewModel>(
          // TODO how to do this with injectable only? -> research StateNotifier instead of ChangeNotifier?
          model: getIt<TransactionViewModel>(),
          onModelReady: (vmodel) =>
              vmodel.init(TransactionState(senderId: this.senderID)),
          builder: (context, vmodel, child) {
            return Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Betrag'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onEditingComplete: () => print('amount editing complete'),
                    ),
                    TextFormField(
                        decoration: InputDecoration(hintText: 'Empfänger'),
                        onEditingComplete: () =>
                            print('empfänger editing complete')),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    PrimaryButton(
                      text: I18n.of(context).personalWalletPay,
                      onPressed: () {
                        // print('onpressed');
                        Navigator.pushNamed(context, PaymentOverviewRoute,
                            arguments: PaymentOverviewArguments(
                                title: 'Geld senden',
                                senderId: vmodel.senderId,
                                recieverId: vmodel.recieverId,
                                amount: vmodel.amount));
                      },
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10),
              ),
            );
          }),
    );
  }
}
