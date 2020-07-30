import 'package:e_coupon/ui/core/services/camera_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/screens/payment/qr_scanner_screen.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../injection.dart';

class QRScannerTestScreen extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScannerTestScreen>
    with SingleTickerProviderStateMixin {
  QRReaderController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController animationController;
  List<CameraDescription> _cameras;
  ICameraService _cameraService = getIt<ICameraService>();
  final double _qrRectSize = 230;

  @override
  void initState() {
    super.initState();

    _cameras = _cameraService.cameras;

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    animationController.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
    verticalPosition = Tween<double>(begin: 0.0, end: _qrRectSize).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear))
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          animationController.reverse();
        } else if (state == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    // pick the first available camera
    if (_cameras.isNotEmpty) {
      onNewCameraSelected(_cameras[0]);
    } else {
      print('keine kamera gefunden');
    }
  }

  Animation<double> verticalPosition;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isShop: false,
      title: 'Yay we are scanning!',
      body: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(
                child: _cameraPreviewWidget(),
              ),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 170,
                ),
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: _qrRectSize,
                      width: _qrRectSize,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2.0)),
                      ),
                    ),
                    SizedBox(
                      height: _qrRectSize,
                      width: _qrRectSize,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: SvgPicture.asset(Assets.qr_code_svg),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: verticalPosition.value,
                      child: Container(
                        width: _qrRectSize,
                        height: 2.0,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 170,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    child: PrimaryButton(text: 'manuell eingeben'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'No camera selected',
        style: TextStyle(
          color: Colors.red,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: QRReaderPreview(controller),
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onCodeRead(dynamic value) {
    showInSnackBar(value.toString());
    // ... do something
    // wait 5 seconds then start scanning again.
    Future.delayed(const Duration(seconds: 5), controller.startScanning);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = QRReaderController(cameraDescription, ResolutionPreset.low,
        [CodeFormat.qr, CodeFormat.pdf417], onCodeRead);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on QRReaderException catch (e) {
      logError(e.code, e.description);
      showInSnackBar('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
      await controller.startScanning();
    }
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
