import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:flutter/material.dart';

class TransactionListEntry {
  final String text;
  final double amount;

  TransactionListEntry(TransactionRecord transactionRecord)
      : this.text = transactionRecord.text,
        this.amount = transactionRecord.amount;
}

class TransactionList extends StatelessWidget {
  final List<TransactionListEntry> entries;
  final BuildContext context;
  final bool isLoading;

  TransactionList({this.entries, @required this.context, this.isLoading});

  Widget _buildListItem(entryLabel, entryAmount) {
    return Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              entryLabel,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              entryAmount.toString(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.end,
            ),
            const Divider(
              color: Colors.grey,
              height: 5,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        isLoading ? ECProgressIndicator() : Container(),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries != null ? entries.length : 0,
              itemBuilder: (context, i) {
                final entry = entries[i];
                return _buildListItem(entry.text, entry.amount);
              }),
        )
      ],
    );

    // TransactionItem('Bäckerei Confiserie Galli', 13.45, 'out'),
    // TransactionItem('Pusteblume GmbH', 25.00, 'in'),
    // Container(
    //   height: 50,
    //   color: Colors.amber[600],
    //   child: const Center(child: Text('Entry A')),
    // ),
    // Container(
    //   height: 50,
    //   color: Colors.amber[500],
    //   child: const Center(child: Text('Entry B')),
    // ),
    // Container(
    //   height: 50,
    //   color: Colors.amber[100],
    //   child: const Center(child: Text('Entry C')),
    // ),
  }
}

class TransactionItem extends StatelessWidget {
  final entryLabel;
  final entryAmount;
  final inOrOut;

  TransactionItem(this.entryLabel, this.entryAmount, this.inOrOut);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 100,
        child: Row(
          children: <Widget>[
            Text(entryLabel),
            Text(entryAmount),
            const Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ));
  }
}
