import 'package:flutter/material.dart';

import 'ec_progress_indicator.dart';

class AmountDisplay extends StatelessWidget {
  final bool isLoading;
  final String amount;
  final String currency;
  final bool isShopColor;

  AmountDisplay(
      {this.isLoading = false, this.amount, this.currency, this.isShopColor});

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
