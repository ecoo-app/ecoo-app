import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Barcode Scanner'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    onPressed: barcodeScanning,
                    child: Text(
                      "Capture Image",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Text(
                  "Scanned Barcode Number",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  barcode,
                  style: TextStyle(fontSize: 25, color: Colors.green),
                ),
              ],
            ),
          )),
    );
  }

  //scan barcode asynchronously
  Future barcodeScanning() async {
    final _aspectTolerance = 0.00;

    final _selectedCamera = -1;
    final _useAutoFocus = true;
    final _autoEnableFlash = false;
    final List<BarcodeFormat> _selectedFormats = [BarcodeFormat.qr];
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

      ScanResult barcode = await BarcodeScanner.scan(options: options);
      // ScanResult barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode.toString());
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
