import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/use_cases/get_wallet.dart';
import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/abstract_qr_scanner.dart';
import 'package:e_coupon/ui/core/services/transfer_service.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
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
  final ITransferService _transferService;
  final HandleTransaction handleTransaction;
  final GetWallet getWallet;

  final formKey = GlobalKey<FormState>();
  final amountInputController = TextEditingController();
  final recieverInputController = TextEditingController();

  PaymentViewModel(this._router, this.qrScanner, this._walletService,
      this._transferService, this.handleTransaction, this.getWallet);

  void init() async {
    var sender = await _walletService.getSelected();
    _transferService.transfer.sender = sender;

    Transfer transfer = _transferService.transfer;
    if (transfer.reciever != null) {
      recieverInputController.value = TextEditingValue(
        text: transfer.reciever.id,
      );
    }

    if (transfer.amount != null) {
      amountInputController.value = TextEditingValue(
        text: transfer.amountLabel,
      );
    }
  }

  void initiateTransaction(String successText) async {
    if (formKey.currentState.validate()) {
      setViewState(Loading());

      _transferService.transfer.amount =
          Utils.balanceFromString(amountInputController.text);

      var recieverOrFailure =
          await getWallet(WalletParams(id: recieverInputController.text));
      recieverOrFailure.fold((failure) => setViewState(Error(failure)),
          (wallet) async {
        _transferService.transfer.reciever = wallet;
        await transfer(successText);
        setViewState(Loaded());
      });
    }
  }

  void transfer(String successText) async {
    var transactionOrFailure = await handleTransaction(TransactionParams(
        sender: _transferService.transfer.sender,
        reciever: _transferService.transfer.reciever,
        amount: _transferService.transfer.amount));

    transactionOrFailure.fold(
        (failure) => onError(failure), (success) => onSuccess(successText));
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

  void onPop() {
    _transferService.reset();
    _router.pop();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    amountInputController.dispose();
    recieverInputController.dispose();
    super.dispose();
  }
}
