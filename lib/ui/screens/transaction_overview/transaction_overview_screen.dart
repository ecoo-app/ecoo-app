import 'package:e_coupon/business/entities/transaction_record.dart';
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
            TransactionListEntry(
                TransactionRecord(text: 'Confiserie', amount: 12.34)),
            TransactionListEntry(
                TransactionRecord(text: 'Pusteblume', amount: -10.00))
          ],
        )
      ]),
    );
  }
}
