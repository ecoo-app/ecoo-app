import 'package:e_coupon/ui/shared/main_layout.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatelessWidget {
  final title;
  final body;

  PaymentScreen({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return new MainLayout(title: new Text('payment'), body: new Text('body'));
  }

  final _aspectTolerance = 0.00;

  final _selectedCamera = -1;
  final _useAutoFocus = true;
  final _autoEnableFlash = false;
  final List<BarcodeFormat> _selectedFormats = [BarcodeFormat.qr];

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": "cancel",
          "flash_on": "flash off",
          "flash_off": "flash on",
        },
        restrictFormat: _selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      //setState(() => scanResult = result);
      print(result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        // setState(() {
        //   result.rawContent = 'The user did not grant the camera permission!';
        // });
        result.rawContent = 'The user did not grant the camera permission!';
        print(result);
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      // setState(() {
      //   scanResult = result;
      // });
      print(result);
    }
  }
}
