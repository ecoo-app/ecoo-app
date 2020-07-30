import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/outlined_secondary_button.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/screens/payment/qr_scanner_view_model.dart';
import 'package:flutter/material.dart';

import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter_svg/svg.dart';

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class QRScannerScreen extends StatelessWidget {
  final double _qrRectSize = 230;

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget(controller) {
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
  Widget build(BuildContext context) {
    return MainLayout(
      isShop: false,
      title: 'Yay we are scanning!',
      body: BaseView<QRScannerViewModel>(
        model: getIt<QRScannerViewModel>(),
        onModelReady: (vmodel) => vmodel.init(),
        builder: (context, vmodel, child) {
          return Stack(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: _cameraPreviewWidget(vmodel.controller),
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
                                border:
                                    Border.all(color: Colors.red, width: 2.0)),
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
                      ],
                    ),
                    SizedBox(
                      height: 170,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 4),
                      child: OutlinedSecondaryButton(
                        text: 'manuell eingeben',
                        onPressed: () => vmodel.next(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
