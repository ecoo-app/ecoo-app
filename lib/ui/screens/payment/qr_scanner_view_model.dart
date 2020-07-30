import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/qr_scan_parser.dart';
import 'package:e_coupon/ui/core/services/transfer_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:flutter/widgets.dart';

import 'package:injectable/injectable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

const String EncryptedLabel = 'encrypted';

@injectable
class QRScannerViewModel extends BaseViewModel {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final IRouter _router;
  final ITransferService _transferService;
  final IWalletService _walletService;
  final IQRScanParser _scanParser;
  QRViewController controller;

  QRScannerViewModel(this._router, this._transferService, this._scanParser,
      this._walletService);

  bool get isShop => _walletService.getSelected().isShop;

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      onCodeRead(scanData);
    });
  }

  void onCodeRead(String value) {
    print(value.toString());
    Transfer transferData;

    if (value.contains(EncryptedLabel)) {
      transferData = _scanParser.parseEncryptedTransaction(value);
    } else {
      transferData = _scanParser.parseTransaction(value);
    }

    _transferService.setTransaction(transferData);

    next();
  }

  void next() {
    _router.pushNamed(PaymentRoute);
  }

  void onBack() {
    _router.pop();
  }
}
