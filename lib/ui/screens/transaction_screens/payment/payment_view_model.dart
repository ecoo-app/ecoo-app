import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/ui/core/services/abstract_qr_scanner.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';

import 'package:injectable/injectable.dart';

@injectable
class TransactionViewModel extends BaseViewModel {
  final HandleTransaction handleTransaction;
  final IQRScanner qrScanner;
  TransactionState transactionData;

  TransactionViewModel({this.handleTransaction, this.qrScanner});

  String get senderId => transactionData.senderId;
  String get recieverId => transactionData.recieverId;
  double get amount => transactionData.amount;
  bool get receiverIsSet => transactionData.recieverIsSet;
  bool get amountIsSet => transactionData.amountIsSet;

  set senderId(String senderId) {
    transactionData.senderId = senderId;
  }

  set recieverId(String recieverId) {
    transactionData.recieverId = recieverId;
  }

  set amount(double amount) {
    transactionData.amount = amount;
  }

  void init(TransactionState transactionData) {
    print(transactionData.senderId);
    this.transactionData = transactionData;
  }
}

// extend from Transaction entity?
class TransactionState {
  String senderId = '';
  String recieverId = '';
  bool recieverIsSet = false;
  double amount = 0;
  bool amountIsSet = false;

  TransactionState({this.senderId, this.recieverId, this.amount});
}
