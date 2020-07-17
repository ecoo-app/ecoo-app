import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/payment/payment_view_model.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:e_coupon/ui/core/widgets/amount_input.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../injection.dart';

class PaymentScreen extends StatelessWidget {
  final senderID;

  PaymentScreen({@required this.senderID});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: I18n.of(context).titlePaymentScreen,
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
                    Form(
                        key: vmodel.formKey,
                        child: Column(
                          children: <Widget>[
                            AmountInputField(
                              controller: vmodel.amountInputController,
                            ),
                            TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return I18n.of(context)
                                        .validationRecieverInput;
                                  }
                                  return null;
                                },
                                controller: vmodel.recieverInputController,
                                decoration: InputDecoration(
                                    hintText:
                                        I18n.of(context).hintRecieverInput),
                                onEditingComplete: () =>
                                    print('empfänger editing complete')),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    PrimaryButton(
                      text: '',
                      onPressed: () {
                        if (vmodel.formKey.currentState.validate()) {
                          Navigator.pushNamed(context, PaymentOverviewRoute,
                              arguments: PaymentOverviewArguments(
                                  title: 'Geld senden',
                                  transactionData: TransactionData(
                                      senderId: vmodel.senderId,
                                      recieverId:
                                          vmodel.recieverInputController.text,
                                      amount: double.parse(
                                          vmodel.amountInputController.text))));
                        }
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
