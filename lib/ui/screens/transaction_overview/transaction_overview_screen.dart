import 'package:e_coupon/ui/core/widgets/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class TransactionOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: Text('Wallets'),
      body: Column(children: <Widget>[
        Text('Bewegungen'),
        TransactionList(
          context: context,
          entries: [
            TransactionListEntry('Confiserie', 12.34),
            TransactionListEntry('Pusteblume', -10.00)
          ],
        )
      ]),
    );
  }
}
