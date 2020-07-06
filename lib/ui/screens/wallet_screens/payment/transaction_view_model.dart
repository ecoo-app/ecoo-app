import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/ui/core/abstract_qr_scanner.dart';
import 'package:e_coupon/ui/core/base_view_model.dart';
import 'package:e_coupon/ui/core/viewstate.dart';
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

  set senderId(String senderId) {
    transactionData.senderId = senderId;
  }

  set recieverId(String recieverId) {
    transactionData.recieverId = recieverId;
  }

  set amount(double amount) {
    transactionData.amount = amount;
  }

  void init() {
    transactionData = TransactionState();
  }

  void initiateTransaction() async {
    setState(ViewStateEnum.Busy);

    var transactionOrFailure = await handleTransaction(TransactionParams(
        senderId: 'sender', recieverId: 'reciever', amount: 10.00));
    transactionOrFailure.fold((failure) => print('FAILURE'),
        (success) => print('transaction succesful'));

    setState(ViewStateEnum.Idle);
  }

  void scanQR() async {
    setState(ViewStateEnum.Busy);

    var scanOrFailure = await qrScanner.scan();
    scanOrFailure.fold(
        (failure) => print('FAILURE'), (result) => print('scan succesful'));

    setState(ViewStateEnum.Idle);
  }
}

// extend from Transaction entity?
class TransactionState {
  String senderId = '';
  String recieverId = '';
  double amount = 0;

  TransactionState();
}
