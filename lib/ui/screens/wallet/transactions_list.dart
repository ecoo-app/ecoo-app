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

  // Widget _buildListItem(TransactionListEntry entry, int index) {
  //   return Container(
  //       // height: 50,
  //       child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       (!hasConnection && index == 0)
  //           ? Icon(Icons.signal_wifi_off)
  //           : Container(),
  //       entry.showDate
  //           ? Padding(
  //               padding: EdgeInsets.only(top: index == 0 ? 16.0 : 30.0),
  //               child: Text(
  //                 // TODO use dateformat of phone
  //                 DateFormat.yMEd('de-CH').format(entry.date),
  //                 style: Theme.of(context).textTheme.caption,
  //               ),
  //             )
  //           : Container(),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Text(
  //               entry.text,
  //               style: Theme.of(context).textTheme.bodyText2,
  //             ),
  //             Text(
  //               entry.isNegative ? '- ${entry.amount}' : '+ ${entry.amount}',
  //               style: Theme.of(context).textTheme.bodyText1,
  //               textAlign: TextAlign.end,
  //             ),
  //           ],
  //         ),
  //       ),
  //       const Divider(
  //         color: ColorStyles.bg_light_gray,
  //         thickness: 1,
  //       ),
  //     ],
  //   ));
  // }
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
