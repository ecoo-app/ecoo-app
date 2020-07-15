import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:e_coupon/ui/screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_layout.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_view_model.dart';
import 'package:e_coupon/ui/core/widgets/amount_display.dart';
import 'package:e_coupon/ui/core/widgets/icon_button.dart';
import 'package:e_coupon/ui/core/widgets/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/transactions_list.dart';
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
          disposeState: false,
          onModelReady: (vmodel) async => await vmodel.setWalletId(walletId),
          builder: (context, vmodel, child) {
            if (vmodel.walletState.value is Loading) {
              return Container();
            } else {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  AmountDisplay(
                    isLoading: vmodel.walletState.value.amount.processingState
                        is Loading,
                    amount: vmodel.walletState.value.amount.value,
                    currency: 'CHF',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  Center(
                    child: Text(
                      vmodel.walletState.processingState is Loaded
                          ? 'Wallet ${vmodel.walletState.value.walletID}'
                          : 'loading',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    // child: Text('Wallet no id'),
                  ),
                  Center(
                    child: Text(vmodel.walletState.processingState is Loaded
                        ? '${vmodel.walletState.value.currency.label}'
                        : 'loading'),
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
                                arguments: vmodel.walletState.value.walletID);
                          },
                        ),
                        CustomIconButton(
                          icon: Icons.call_received,
                          text: I18n.of(context).privateWalletRecieve,
                          onPressed: () {
                            Navigator.pushNamed(context, RequestPaymentRoute,
                                arguments: vmodel.walletState.value.walletID);
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
                              title: 'Zahlung bestätigen', shouldScan: true));
                    },
                  ),
                  Expanded(
                    child: TransactionList(
                      isLoading: vmodel.walletState.value.transactions
                          .processingState is Loading,
                      context: context,
                      entries: vmodel.walletState.value.transactions.value,
                    ),
                  ),
                  Center(
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, TransactionOverviewRoute);
                      },
                      icon: Icon(Icons.folder_open),
                      label: Text(I18n.of(context).showAllTransactions),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
