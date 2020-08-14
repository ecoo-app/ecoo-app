import 'dart:async';

import 'network_info.dart';

// @devEnv
// @mockEnv
// @LazySingleton(as: INetworkInfo)
class MockNetworkInfo implements INetworkInfo {
  @override
  Future<bool> get isConnected async {
    return true;
  }
}
