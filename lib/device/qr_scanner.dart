import 'package:barcode_scan/barcode_scan.dart';
import 'package:e_coupon/ui/core/services/abstract_qr_scanner.dart'
    as scannerInterface;
import 'package:flutter/services.dart';

// @Environment(Env.dev)
// @Injectable(as: scannerInterface.IQRScanner)
class QRScanner implements scannerInterface.IQRScanner {
  @override
  scan() async {
    // TODO: implement scan
    throw UnimplementedError();
  }

  Future barcodeScanning() async {
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
