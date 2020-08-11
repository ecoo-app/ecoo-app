import 'dart:async';

import 'package:e_coupon/injection.dart';
import 'package:injectable/injectable.dart';

import 'network_info.dart';

@devEnv
@mockEnv
@LazySingleton(as: INetworkInfo)
class MockNetworkInfo implements INetworkInfo {
  @override
  Future<bool> get isConnected async {
    return true;
  }
}
