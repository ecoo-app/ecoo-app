import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/screens/payment/payment_overview_view_model.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PaymentOverviewScreen extends StatelessWidget {
  final TransactionData arguments;

  PaymentOverviewScreen({@required this.arguments});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isShop: false,
      title: I18n.of(context).titlePaymentOverview,
      body: BaseView<PaymentOverviewViewModel>(
        model: getIt<PaymentOverviewViewModel>(), // TODO injectable
        onModelReady: (vmodel) => vmodel.initState(
          transactionData: arguments,
        ),
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
              Navigator.pushNamed(context, SuccessRoute,
                  arguments: SuccessScreenArguments(
                      isShop: false,
                      text: I18n.of(context).paymentSuccessful,
                      iconAssetPath: Assets.check_double_svg));
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
                  'senden an ${vmodel.transactionData.reciever.id}',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                PrimaryButton(
                  text: I18n.of(context).buttonPaymentOverview,
                  isLoading: vmodel.viewState is Loading,
                  onPressed: () async {
                    vmodel.initiateTransaction(
                        I18n.of(context).paymentSuccessful);
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

// ignore: unused_element
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
