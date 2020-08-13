import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
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
  final IWalletService _walletService;
  final ITransferService _transferService;
  final IWalletRepo _walletRepo;

  final formKey = GlobalKey<FormState>();
  final amountInputController = TextEditingController();
  final recieverInputController = TextEditingController();

  bool isShop;

  PaymentViewModel(this._router, this._walletService, this._transferService,
      this._walletRepo);

  void init() {
    var sender = _walletService.getSelected();
    print('selected wallet ${sender.id}');
    isShop = sender.isShop;
    _transferService.transfer.sender = sender;

    Transfer transfer = _transferService.transfer;
    if (transfer.destWalletId != null) {
      recieverInputController.value = TextEditingValue(
        text: transfer.destWalletId,
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
          await _walletRepo.getWalletData(recieverInputController.text);

      await recieverOrFailure.fold((failure) {
        setViewState(Error(failure));
      }, (wallet) async {
        await transfer(successText, wallet);
        setViewState(Loaded());
      });
    }
  }

  void transfer(String successText, WalletEntity destWallet) async {
    var transactionOrFailure = await _walletRepo.handleTransaction(
        _transferService.transfer.sender,
        destWallet,
        _transferService.transfer.amount);

    transactionOrFailure.fold(
        (failure) => onError(failure), (success) => onSuccess(successText));
  }

  void onSuccess(String successText) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _router.pushNamed(SuccessRoute,
          arguments: SuccessScreenArguments(
              isShop: false,
              text: successText,
              iconAssetPath: Assets.check_double_svg,
              nextRoute: WalletDetailRoute));
    });
  }

  void onError(Failure failure) {
    _router.pushNamed(ErrorRoute);
  }

  void onBack() {
    _transferService.reset();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    amountInputController.dispose();
    recieverInputController.dispose();
    super.dispose();
  }
}
