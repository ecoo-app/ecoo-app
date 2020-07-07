import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/screens/transaction_screens/payment/payment_overview_view_model.dart';
import 'package:e_coupon/ui/screens/transaction_screens/transaction_data.dart';
import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:flutter/cupertino.dart';

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
        model: getIt<PaymentOverviewViewModel>(), // TODO
        onModelReady: (vmodel) => vmodel.initState(
            transactionData: arguments.transactionData,
            shouldScanQR: arguments.shouldScan),
        builder: (context, vmodel, child) {
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
          );
        },
      ),
    );
  }
}
