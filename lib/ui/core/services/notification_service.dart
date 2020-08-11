import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final IWalletSource _walletSource;

  NotificationService(this._walletSource);

  testRegisterDevice() async {
    final permissionGranted = await _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
            sound: false, badge: true, alert: true, provisional: true));
    if (permissionGranted) {
      final token = await _firebaseMessaging.getToken();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String deviceID;
      String name;
      if (Platform.isAndroid) {
        var build = await deviceInfo.androidInfo;
        name = build.model;
        deviceID = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfo.iosInfo;
        name = data.name;
        deviceID = data.identifierForVendor; //UUID for iOS
      }
      await _walletSource.walletService
          .registerDevice(token, deviceID: deviceID, name: name);
    }
  }
}
