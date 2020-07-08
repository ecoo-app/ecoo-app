import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:e_coupon/ui/core/services/abstract_qr_scanner.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:e_coupon/ui/screens/transaction_screens/transaction_data.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@injectable
class PaymentOverviewViewModel extends BaseViewModel {
  final HandleTransaction handleTransaction;
  final IQRScanner qrScanner;
  TransactionData transactionData;

  PaymentOverviewViewModel(this.handleTransaction, this.qrScanner);

  void initState({bool shouldScanQR, TransactionData transactionData}) {
    if (transactionData != null) {
      this.transactionData = transactionData;
    } else {
      this.transactionData = TransactionData();
    }
    if (shouldScanQR) {
      scanQR();
    }
  }

  void initiateTransaction() async {
    setViewState(Loading());

    var transactionOrFailure = await handleTransaction(TransactionParams(
        senderId: transactionData.senderId,
        recieverId: transactionData.recieverId,
        amount: transactionData.amount));
    transactionOrFailure.fold((failure) => setViewState(Error(failure)),
        (success) => setViewState(Success(success)));
  }

  void scanQR() async {
    setViewState(Loading());

    var scanOrFailure = await qrScanner.scan();
    scanOrFailure.fold((failure) => print('FAILURE'), (result) {
      transactionData.recieverId = result.walletID;
      if (result.amount != null) {
        transactionData.amount = result.amount;
      }
    });

    setViewState(Initial());
  }
}
