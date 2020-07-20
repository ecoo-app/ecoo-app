import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/lib/mock_data.dart';
import 'package:e_coupon/ui/core/services/abstract_qr_scanner.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';

@Injectable(as: IQRScanner)
class MockQRScanner implements IQRScanner {
  @override
  Future<Either<Failure, ScannedResult>> scan() async {
    try {
      unawaited(BarcodeScanner.scan());
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        print('No camera permission!');
        // setState(() {
        //   this.barcode = 'No camera permission!';
        // });
      } else {
        print('Unknown error: $e');
        // setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      print('Nothing captured.');
      // setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      print('Unknown error: $e');
      // setState(() => this.barcode = 'Unknown error: $e');
    }

    var completer = Completer<Either<Failure, ScannedResult>>();
    completer.complete(
        Right(ScannedResult(walletID: PrivateWalletID, amount: 120.50)));
    return completer.future;
  }
}
