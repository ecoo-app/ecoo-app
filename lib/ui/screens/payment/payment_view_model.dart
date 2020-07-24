import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/abstract_qr_scanner.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:injectable/injectable.dart';

@injectable
class PaymentViewModel extends BaseViewModel {
  final IRouter _router;
  final IQRScanner qrScanner;

  TransactionData _transaction;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final formKey = GlobalKey<FormState>();
  final amountInputController = TextEditingController();
  final recieverInputController = TextEditingController();

  PaymentViewModel(this._router, this.qrScanner);

  void init(WalletEntity sender) {
    this._transaction = TransactionData(sender: sender);
    scanQR();
  }

  void next() {
    if (formKey.currentState.validate()) {
      _transaction.reciever = WalletEntity.createReciever(
          recieverInputController.text, recieverInputController.text);
      _transaction.amount = Utils.balanceFromString(amountInputController.text);
      _toPaymentOverviewScreen();
    }
  }

  void _toPaymentOverviewScreen() async {
    await _router.pushNamed(PaymentOverviewRoute, arguments: _transaction);
  }

  void scanQR() async {
    var scanOrFailure = await qrScanner.scan();
    scanOrFailure.fold((failure) => print('FAILURE'), (result) {
      _transaction.reciever =
          WalletEntity.createReciever(result.walletID, result.walletID);
      if (result.amount != null) {
        _transaction.amount = result.amount;
        _toPaymentOverviewScreen();
      } else {
        recieverInputController.text = result.walletID;
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    // TODO call dispose -> this view model is not disposed
    amountInputController.dispose();
    recieverInputController.dispose();
    super.dispose();
  }
}
