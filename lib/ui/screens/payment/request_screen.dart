import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/screens/payment/request_qrbill_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_view_model.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:e_coupon/ui/core/widgets/amount_input.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  final String requesterId;

  RequestScreen({@required this.requesterId});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'anfordern',
      body: BaseView<RequestViewModel>(
        model: getIt<RequestViewModel>(),
        builder: (_, vmodel, __) {
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
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  PrimaryButton(
                    text: I18n.of(context).personalWalletPay,
                    onPressed: () {
                      if (vmodel.formKey.currentState.validate()) {
                        Navigator.pushNamed(context, RequestQRBillRoute,
                            arguments: RequestData(
                                requesterId: requesterId,
                                amount: double.parse(
                                    vmodel.amountInputController.text)));
                      }
                    },
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10),
            ),
          );
        },
      ),
    );
  }
}
