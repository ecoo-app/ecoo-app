import 'dart:async';

import 'package:injectable/injectable.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: INetworkInfo)
class NetworkInfo implements INetworkInfo {
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected {
    var completer = Completer<bool>();
    completer.complete(true);
    return completer.future;
  }
}
