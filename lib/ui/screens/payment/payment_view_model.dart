import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/abstract_qr_scanner.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/services/wallet_scervice.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import 'package:injectable/injectable.dart';

@injectable
class PaymentViewModel extends BaseViewModel {
  final IRouter _router;
  final IQRScanner qrScanner;
  final IWalletService _walletService;
  final HandleTransaction handleTransaction;

  Transfer _transaction;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final formKey = GlobalKey<FormState>();
  final amountInputController = TextEditingController();
  final recieverInputController = TextEditingController();

  PaymentViewModel(this._router, this.qrScanner, this._walletService,
      this.handleTransaction);

  void init() {
    this._transaction = Transfer(sender: Right(_walletService.selectedWallet));
  }

  bool validate() {
    if (formKey.currentState.validate()) {
      _transaction.reciever = Right(WalletEntity.createReciever(
          recieverInputController.text, recieverInputController.text));
      _transaction.amount =
          Right(Utils.balanceFromString(amountInputController.text));

      return true;
    }
    return false;
  }

  void initiateTransaction(String successText) async {
    if (validate()) {
      setViewState(Loading());

      var transactionOrFailure = await handleTransaction(TransactionParams(
          sender: _transaction.sender.fold((l) => null, (r) => r),
          reciever: _transaction.reciever.fold((l) => null, (r) => r),
          amount: _transaction.amount.fold((l) => null, (r) => r)));

      transactionOrFailure.fold(
          (failure) => onError(failure), (success) => onSuccess(successText));

      setViewState(Loaded());
    }
  }

  void onSuccess(String successText) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _router.pushNamed(SuccessRoute,
          arguments: SuccessScreenArguments(
              isShop: false,
              text: successText,
              iconAssetPath: Assets.check_double_svg));
    });
  }

  void onError(Failure failure) {
    _router.pushNamed(ErrorRoute);
  }

  void scanQR() async {
    var scanOrFailure = await qrScanner.scan();
    scanOrFailure.fold((failure) => print('FAILURE'), (result) {
      _transaction.reciever =
          Right(WalletEntity.createReciever(result.walletID, result.walletID));
      if (result.amount != null) {
        _transaction.amount = Right(result.amount);
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
