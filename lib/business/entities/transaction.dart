import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/services/utils.dart';

class Empty {}

class Transfer {
  // Either<Empty, WalletEntity> sender;
  // Either<Empty, WalletEntity> reciever;
  // Either<Empty, int> amount;
  WalletEntity sender;
  String destWalletId;
  int amount;

  Transfer({this.sender, this.destWalletId, this.amount});

  String get amountLabel => Utils.moneyToString(this.amount);
}

// abstract class ITransfer {
//   int amount;
//   ITransfer(this.amount);
//   String get amountLabel => Utils.moneyToString(this.amount);
// }

// class Transfer extends ITransfer {
//   WalletEntity sender;
//   String destWalletId;
//   Transfer({this.sender, this.destWalletId, amount}) : super(amount);
// }

// class PaperTransfer extends ITransfer {
//   PaperWallet source;
//   WalletEntity destination;
//   PaperTransfer({this.source, this.destination, amount}) : super(amount);
// }
