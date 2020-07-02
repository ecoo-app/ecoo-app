import 'package:barcode_scan/barcode_scan.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/repo_definitions/abstract_scanner_repo.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IScannerRepo)
class ScannerRepo implements IScannerRepo {
  @override
  Future<Either<Failure, Transaction>> scanQR() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();

      print(barcode.rawContent);

      //setState(() => this.barcode = barcode.rawContent);
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
  }
}
