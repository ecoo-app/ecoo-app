import 'package:e_coupon/ui/screens/payment/qr_scanner_screen.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:injectable/injectable.dart';

abstract class ICameraService {
  void init();
  List<CameraDescription> get cameras;
}

@LazySingleton(as: ICameraService)
class CameraService extends ICameraService {
  List<CameraDescription> _cameras;

  void init() async {
    try {
      _cameras = await availableCameras();
    } on QRReaderException catch (e) {
      logError(e.code, e.description);
    }
  }

  @override
  List<CameraDescription> get cameras => this._cameras;
}
