import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/widgets/transactions/transaction_list_header.dart';
import 'package:e_coupon/ui/core/widgets/transactions/transaction_list_item.dart';
import 'package:flutter/material.dart';

import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';

abstract class TransactionListEntry {}

class TransactionListHeaderEntry implements TransactionListEntry {
  final DateTime date;

  TransactionListHeaderEntry(this.date);
}

class TransactionListItemEntry implements TransactionListEntry {
  final DateTime date;
  final String text;
  final int amount;
  final bool isNegative;

  TransactionListItemEntry(
      {@required this.date,
      @required this.text,
      @required this.amount,
      this.isNegative = false});
}

class TransactionList extends StatelessWidget {
  final Stream<List<TransactionListEntry>> transactions;

  TransactionList({
    this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TransactionListEntry>>(
      stream: transactions,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, left: 25, right: 25),
            child:
                TransactionListItem(text: I18n.of(context).emptyTransactions),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var item = snapshot.data[index];
                if (item is TransactionListHeaderEntry) {
                  return TransactionListHeader(
                    index: index,
                    titleDate: item.date,
                  );
                }
                if (item is TransactionListItemEntry) {
                  return TransactionListItem(
                    text: item.text,
                    amount: item.amount,
                    isNegative: item.isNegative,
                  );
                }

                return TransactionListItem(
                    text: I18n.of(context).emptyTransactions);
              });
        }

        return Center(child: ECProgressIndicator());
      },
    );
  }
}
