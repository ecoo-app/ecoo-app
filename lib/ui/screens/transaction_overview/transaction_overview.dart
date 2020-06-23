import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:e_coupon/ui/shared/transactions_list.dart';
import 'package:flutter/material.dart';

class TransactionOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: Text('Wallets'),
      body: Column(children: <Widget>[
        Text('Bewegungen'),
        TransactionList(
          entries: [
            TransactionListEntry('Confiserie', 12.34),
            TransactionListEntry('Pusteblume', -10.00)
          ],
        )
      ]),
    );
  }
}
