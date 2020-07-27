import 'package:e_coupon/main.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/camera_service.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:injectable/injectable.dart';

@injectable
class QRScannerViewModel extends BaseViewModel {
  QRReaderController controller;
  List<CameraDescription> _cameras;
  ICameraService _cameraService;
  IRouter _router;

  QRScannerViewModel(this._cameraService, this._router);

  void init() {
    _cameras = _cameraService.cameras;

    // pick the first available camera
    if (_cameras.isNotEmpty) {
      onNewCameraSelected(_cameras[0]);
    } else {
      print('keine kamera gefunden');
    }
  }

  void onCodeRead(dynamic value) {
    print(value.toString());
    next();
  }

  void next() {
    _router.pushNamed(PaymentRoute);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = QRReaderController(cameraDescription, ResolutionPreset.low,
        [CodeFormat.qr, CodeFormat.pdf417], onCodeRead);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on QRReaderException catch (e) {
      logError(e.code, e.description);
      print('Error: ${e.code}\n${e.description}');
    }

    await controller.startScanning();
  }
}
