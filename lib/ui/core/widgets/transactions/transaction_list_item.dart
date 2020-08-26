import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  final String text;
  final int amount;
  final bool isNegative;

  const TransactionListItem(
      {Key key, @required this.text, this.amount, this.isNegative})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .merge(TextStyle(color: ColorStyles.bg_gray)),
            ),
            amount != null
                ? Text(
                    isNegative
                        ? Utils.moneyToString(amount)
                        : '+ ${Utils.moneyToString(amount)}',
                    style: Theme.of(context).textTheme.bodyText1.merge(
                        TextStyle(
                            color: isNegative
                                ? ColorStyles.black
                                : ColorStyles.green)),
                    textAlign: TextAlign.end,
                  )
                : SizedBox.shrink(),
          ],
        ),
        const Divider(
          color: ColorStyles.bg_light_gray,
          thickness: 1,
        ),
      ],
    );
  }
}
