import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/services/utils.dart';

class Empty {}

class Transfer {
  // Either<Empty, WalletEntity> sender;
  // Either<Empty, WalletEntity> reciever;
  // Either<Empty, int> amount;
  WalletEntity sender;
  WalletEntity reciever;
  int amount;

  Transfer({this.sender, this.reciever, this.amount});

  String toAmountCurrencyLabel() =>
      Utils.toAmountCurrencyLabel(reciever.currency, amount);

  String get amountLabel => Utils.moneyToString(this.amount);
}
