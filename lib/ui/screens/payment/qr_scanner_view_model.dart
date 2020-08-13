import 'dart:convert';

import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/transfer_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:ecoupon_lib/models/paper_wallet.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';

import 'package:injectable/injectable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

@injectable
class QRScannerViewModel extends BaseViewModel {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final IRouter _router;
  final ITransferService _transferService;
  final IWalletService _walletService;
  final IWalletRepo _walletRepo;
  QRViewController controller;
  String successText = '';

  QRScannerViewModel(this._router, this._transferService, this._walletService,
      this._walletRepo);

  bool get isShop => _walletService.getSelected().isShop;

  void init(String successText) {
    this.successText = successText;
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print(scanData);
      if (num.tryParse(scanData) != null) {
        print('scanning...');
        // bracode found. do more scanning until a json is found
      } else {
        onCodeRead(scanData);
      }
    });
  }

  void onCodeRead(String value) async {
    this.controller.pauseCamera();

    var decodedValue = jsonDecode(value);

    if (decodedValue.containsKey(Constants.qrDataPublicKey)) {
      await onPaperTransfer(
        PaperWallet(
            decodedValue[Constants.qrDataDestinationId],
            decodedValue[Constants.qrDataNonce],
            decodedValue[Constants.qrDataPublicKey]),
        decodedValue[Constants.qrDataAmount],
      );
    } else {
      _transferService.setTransaction(Transfer(
          sender: _walletService.getSelected(),
          destWalletId: decodedValue[Constants.qrDataDestinationId],
          amount: decodedValue[Constants.qrDataAmount]));

      next();
    }
  }

  void next() {
    _router.pushNamed(PaymentRoute);
  }

  void onPaperTransfer(PaperWallet source, int amount) async {
    setViewState(Loading());
    var transactionOrFailure = await _walletRepo.handlePaperTransfer(
        source, _walletService.getSelected(), amount);

    transactionOrFailure.fold((failure) {
      print(failure);
      setViewState(Error(failure));
    }, (success) => onSuccess());
    setViewState(Loaded());
  }

  void onSuccess() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _router.pushNamed(SuccessRoute,
          arguments: SuccessScreenArguments(
              isShop: _walletService.getSelected().isShop,
              text: successText,
              iconAssetPath: Assets.cash_register_svg));
    });
  }

  void onBack() {
    _router.pop();
  }
}
