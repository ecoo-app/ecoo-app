import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

abstract class INotificationService {
  Future<void> registerDevice();

  void setTransferNotificationListener(ITransferNotificationListener listener);
  void removeTransfertNotificationListener();
}

abstract class ITransferNotificationListener {
  void onTransfer();
}

@LazySingleton(as: INotificationService)
class NotificationService extends INotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final IWalletSource _walletSource;
  final ISettingsService _settingsService;
  final String notificationDeviceRegistered = 'notifications_registered';

  ITransferNotificationListener _transferNotificationListener;

  NotificationService(this._walletSource, this._settingsService);

  void initNotifications() {
    // print('notifications inited');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // onMessage: {notification: {title: eCoupon, body: You have received 0.01 CHF from DJ888240}, data: {}}
        // print("onMessage: $message, $_transferNotificationListener");
        this._onMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        // print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        // print("onResume: $message");
      },
    );
  }

  void _onMessage(Map<String, dynamic> message) {
    if (this._transferNotificationListener != null) {
      this._transferNotificationListener.onTransfer();
    }
  }

  Future<void> registerDevice() async {
    try {
      if (_settingsService.getBool(notificationDeviceRegistered) == null ||
          !_settingsService.getBool(notificationDeviceRegistered)) {
        final permissionGranted = await _firebaseMessaging
            .requestNotificationPermissions(const IosNotificationSettings(
                sound: false, badge: true, alert: true, provisional: true));

        if (permissionGranted == null || permissionGranted) {
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
        await _settingsService.setBool(notificationDeviceRegistered, true);
      }

      initNotifications();
    } catch (e) {
      print(e);
    }
  }

  @override
  void setTransferNotificationListener(ITransferNotificationListener listener) {
    this._transferNotificationListener = listener;
  }

  @override
  void removeTransfertNotificationListener() {
    this._transferNotificationListener = null;
  }
}
