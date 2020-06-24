import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/screens/wallet_screens/payment/qrGeneratorTest_screen.dart';
import 'package:e_coupon/ui/screens/wallet_screens/payment/qrTest_screen.dart';
import 'package:e_coupon/ui/screens/wallet_screens/transaction_overview/transaction_overview.dart';
import 'package:e_coupon/ui/screens/wallet_screens/wallets/wallet_screen.dart';
import 'package:e_coupon/ui/shared/icon_button.dart';
import 'package:e_coupon/ui/shared/primary_button.dart';
import 'package:e_coupon/ui/shared/transactions_list.dart';
import 'package:flutter/material.dart';

import 'wallet_layout.dart';

class WalletState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    // return new PaymentScreen();
    return WalletLayout(
        title: Text('my wallet'),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('Wallet 8A83Di8U83Di'),
            ),
            Center(
              child: Text('Steffisburg'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              CustomIconButton(
                icon: Icons.send,
                text: I18n.of(context).privateWalletSend,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerateScreen()),
                  );
                },
              ),
              CustomIconButton(
                icon: Icons.call_received,
                text: I18n.of(context).privateWalletRecieve,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerateScreen()),
                  );
                },
              )
            ]),
            PrimaryButton(
              text: I18n.of(context).personalWalletPay,
              onPressed: () {
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => PaymentScreen()),
                  MaterialPageRoute(builder: (context) => QRScreen()),
                );
              },
            ),
            TransactionList(
              entries: [
                TransactionListEntry('Confiserie', 12.34),
                TransactionListEntry('Pusteblume', -10.00)
              ],
            ),
            Center(
                child: FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionOverview()),
                );
              },
              icon: Icon(Icons.more_vert),
              label: Text(I18n.of(context).showAllTransactions),
            ))
            //new Row(children: <Widget>[new PrimaryButton(text: 'gradient')])
          ],
        ));
  }
}
