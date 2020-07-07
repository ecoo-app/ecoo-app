import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';

import 'package:e_coupon/ui/screens/wallet_screens/payment/qrGeneratorTest_screen.dart';
import 'package:e_coupon/ui/screens/wallet_screens/transaction_overview/transaction_overview.dart';
import 'package:e_coupon/ui/screens/wallet_screens/wallet/wallet_screen.dart';
import 'package:e_coupon/ui/shared/icon_button.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:e_coupon/ui/shared/transactions_list.dart';
import 'package:flutter/material.dart';

import '../wallet_view_model.dart';
import 'wallet_layout.dart';

class WalletState extends State<WalletScreen> {
  final walletId; // where to put this? here or view model?
  WalletState(this.walletId);

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
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                        ),
                        Center(
                          child: Text('Wallet ${vmodel.walletDetail.id}'),
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
                                  Navigator.push(
                                    // TODO change to named route
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GenerateScreen()),
                                  );
                                },
                              ),
                              CustomIconButton(
                                icon: Icons.call_received,
                                text: I18n.of(context).privateWalletRecieve,
                                onPressed: () {
                                  Navigator.push(
                                    // TODO change to named route
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GenerateScreen()),
                                  );
                                },
                              )
                            ]),
                        PrimaryButton(
                          text: I18n.of(context).personalWalletPay,
                          onPressed: () {
                            Navigator.pushNamed(context, PaymentRoute,
                                arguments: vmodel.walletDetail.id);
                          },
                        ),
                        TransactionList(
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
