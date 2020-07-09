import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:e_coupon/ui/screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/transaction_overview/transaction_overview.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_layout.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_view_model.dart';
import 'package:e_coupon/ui/shared/ec_progress_indicator.dart';
import 'package:e_coupon/ui/shared/icon_button.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:e_coupon/ui/shared/transactions_list.dart';
import 'package:flutter/material.dart';

import '../../../injection.dart';

class WalletScreen extends StatelessWidget {
  final walletId;

  WalletScreen({Key key, @required this.walletId});

  @override
  Widget build(BuildContext context) {
    // return new PaymentScreen();
    return WalletLayout(
        title: Text('my wallet'),
        body: BaseView<WalletViewModel>(
            // TODO how to do this with injectable only?
            model: getIt<WalletViewModel>(),
            onModelReady: (vmodel) => vmodel.loadWalletDetail(walletId),
            builder: (context, vmodel, child) {
              return vmodel.state == ViewStateEnum.Busy
                  ? Center(child: ECProgressIndicator())
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                        ),
                        Center(
                          child: Text(
                            'Wallet ${vmodel.walletDetail.id}',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          // child: Text('Wallet no id'),
                        ),
                        Center(
                          child: Text('${vmodel.walletDetail.currency.label}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomIconButton(
                                icon: Icons.send,
                                text: I18n.of(context).privateWalletSend,
                                onPressed: () {
                                  Navigator.pushNamed(context, PaymentRoute,
                                      arguments: vmodel.walletDetail.id);
                                },
                              ),
                              CustomIconButton(
                                icon: Icons.call_received,
                                text: I18n.of(context).privateWalletRecieve,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RequestPaymentRoute,
                                      arguments: vmodel.walletDetail.id);
                                  // Navigator.push(
                                  //   // TODO change to named route
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => GenerateScreen()),
                                  // );
                                },
                              )
                            ]),
                        PrimaryButton(
                          text: I18n.of(context).personalWalletPay,
                          onPressed: () {
                            Navigator.pushNamed(context, PaymentOverviewRoute,
                                arguments: PaymentOverviewArguments(
                                    title: 'Zahlung bestätigen',
                                    shouldScan: true));
                          },
                        ),
                        TransactionList(
                          context: context,
                          entries: vmodel.walletDetailTransactions,
                        ),
                        Center(
                            child: FlatButton.icon(
                          onPressed: () {
                            Navigator.push(
                              // TODO change to named route
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransactionOverview()),
                            );
                          },
                          icon: Icon(Icons.folder_open),
                          label: Text(I18n.of(context).showAllTransactions),
                        ))
                      ],
                    );
            }));
  }
}
