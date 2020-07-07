import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/screens/transaction_screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/transaction_screens/payment/payment_view_model.dart';
import 'package:e_coupon/ui/shared/amount_input.dart';
import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../injection.dart';
import '../transaction_data.dart';

class PaymentScreen extends StatelessWidget {
  final senderID;

  PaymentScreen({@required this.senderID});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: Text('scan'),
      // TODO does it need a view model?
      body: BaseView<PaymentViewModel>(
          // TODO how to do this with injectable only? -> research StateNotifier instead of ChangeNotifier?
          model: getIt<PaymentViewModel>(),
          onModelReady: (vmodel) => vmodel.init(this.senderID),
          builder: (context, vmodel, child) {
            return Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    AmountInputField(
                      controller: vmodel.amountInputController,
                    ),
                    TextFormField(
                        controller: vmodel.recieverInputController,
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
                                transactionData: TransactionData(
                                    senderId: vmodel.senderId,
                                    recieverId:
                                        vmodel.recieverInputController.text,
                                    amount: double.parse(
                                        vmodel.amountInputController.text))));
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
