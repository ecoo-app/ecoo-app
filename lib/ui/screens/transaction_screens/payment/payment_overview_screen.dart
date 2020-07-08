import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:e_coupon/ui/screens/transaction_screens/payment/payment_overview_view_model.dart';
import 'package:e_coupon/ui/screens/transaction_screens/transaction_data.dart';
import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PaymentOverviewArguments {
  final bool shouldScan;
  final String title;
  final TransactionData transactionData;

  PaymentOverviewArguments(
      {this.title, this.shouldScan = false, this.transactionData});
}

class PaymentOverviewScreen extends StatelessWidget {
  final PaymentOverviewArguments arguments;

  PaymentOverviewScreen({@required this.arguments});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: Text('Geld senden'),
      body: BaseView<PaymentOverviewViewModel>(
        model: getIt<PaymentOverviewViewModel>(), // TODO injectable
        onModelReady: (vmodel) => vmodel.initState(
            transactionData: arguments.transactionData,
            shouldScanQR: arguments.shouldScan),
        builder: (context, vmodel, child) {
          // TODO show loading and success in a pop up?
          // if (vmodel.viewState is Loading) {
          //   return Center(child: CircularProgressIndicator());
          // } else if (vmodel.viewState is Success) {
          //   return Text('success');
          // } else

          // Navigator.pushNamed(context, SuccessRoute);
          if (vmodel.viewState is Success) {
            // wait for the widget build process to finish (because vm setState) and then push new route
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, SuccessRoute);
              // Navigator.of(context)
              //     .pushNamedAndRemoveUntil(SuccessRoute, (route) => false);
            });
          }
          return Container(
            child: Column(
              children: <Widget>[
                Text(
                  '${vmodel.transactionData.amount} CHF',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Text(
                  'senden an ${vmodel.transactionData.recieverId}',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                PrimaryButton(
                  text: I18n.of(context).personalWalletPay,
                  isLoading: vmodel.viewState is Loading,
                  onPressed: () async {
                    vmodel.initiateTransaction();
                    // Navigator.pushNamed(
                    //   context,
                    //   WalletDetailRoute,
                    // );
                  },
                ),
              ],
            ),
            padding: const EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10),
          );
        },
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
