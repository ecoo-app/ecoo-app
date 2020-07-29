import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/transfer_service.dart';
import 'package:e_coupon/ui/core/services/utils.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestViewModel extends BaseViewModel {
  final ITransferService _transferService;
  final IWalletService _walletService;
  final IRouter _router;
  final formKey = GlobalKey<FormState>();
  final amountInputController = TextEditingController();
  WalletEntity wallet;

  RequestViewModel(this._transferService, this._walletService, this._router);

  void init() {
    this.wallet = _walletService.getSelected();
  }

  void next() {
    if (formKey.currentState.validate()) {
      print(amountInputController.text);
      _transferService.setTransaction(Transfer(
          reciever: wallet,
          amount: Utils.balanceFromString(amountInputController.text)));
      _router.pushNamed(RequestQRBillRoute);
    }
  }
}
