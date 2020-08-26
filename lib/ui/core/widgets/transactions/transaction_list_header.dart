import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TransactionListHeader extends StatelessWidget {
  final int index;
  final DateTime titleDate;

  const TransactionListHeader({Key key, this.index, this.titleDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: index == 0 ? 16.0 : 30.0, bottom: 8),
      child: Text(
        DateFormat.yMEd('de-CH').format(titleDate),
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
