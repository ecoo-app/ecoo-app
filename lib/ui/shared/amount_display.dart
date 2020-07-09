import 'package:e_coupon/ui/shared/ec_progress_indicator.dart';
import 'package:flutter/material.dart';

class AmountDisplay extends StatelessWidget {
  final bool isLoading;
  final double amount;
  final String currency;

  AmountDisplay({this.isLoading, this.amount, this.currency});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ECProgressIndicator(),
              Text(
                '$amount $currency',
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          )
        : Center(
            child: Text(
              '$amount $currency',
              style: Theme.of(context).textTheme.headline2,
            ),
          );
  }
}
