import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';

class TransactionListEntry {
  final bool showDate;
  final DateTime date;
  final String text;
  final String amount;
  final bool isNegative;

  TransactionListEntry(
      {@required this.date,
      @required this.text,
      @required this.amount,
      this.showDate = false,
      this.isNegative = false});

  //       factory TransactionListEntry.from(Transaction other, String thisWalletId) {
  //         var isNegative = thisWalletId == other.from;
  //   return TransactionListEntry(
  //       other.created,
  //       isNegative ? other.to : other.from,
  //       Utils.moneyToString(other.amount),
  //       other.uid,
  //       other.addressStreet,
  //       other.addressTown,
  //       other.addressPostalCode,
  //       other.verificationStage);
  // }

  // lib_company.CompanyProfile toLibProfile() {
  //   return lib_company.CompanyProfile(
  //     uuid,
  //     walletId,
  //     name,
  //     uid,
  //     addressStreet,
  //     addressTown,
  //     addressPostalCode,
  //     verificationStage,
  //   );
  // }
}

class TransactionList extends StatelessWidget {
  final List<TransactionListEntry> entries;
  final BuildContext context;
  final bool isLoading;
  final bool hasConnection;

  TransactionList(
      {this.entries,
      @required this.context,
      this.isLoading,
      this.hasConnection = true});

  Widget _buildListItem(TransactionListEntry entry, int index) {
    return Container(
        // height: 50,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (!hasConnection && index == 0)
            ? Icon(Icons.signal_wifi_off)
            : Container(),
        entry.showDate
            ? Padding(
                padding: EdgeInsets.only(top: index == 0 ? 16.0 : 30.0),
                child: Text(
                  DateFormat.yMEd('de-CH').format(entry.date),
                  style: Theme.of(context).textTheme.caption,
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                entry.text,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                entry.isNegative ? '- ${entry.amount}' : '+ ${entry.amount}',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        const Divider(
          color: ColorStyles.bg_light_gray,
          thickness: 1,
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
              padding: const EdgeInsets.all(0),
              itemCount: entries != null ? entries.length : 0,
              itemBuilder: (context, i) {
                final entry = entries[i];
                return _buildListItem(entry, i);
              }),
        )
      ],
    );
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
