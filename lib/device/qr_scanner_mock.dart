import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:e_coupon/data/lib/mock_data.dart';
import 'package:e_coupon/ui/core/abstract_qr_scanner.dart';
import 'package:injectable/injectable.dart';

import '../injection.dart';

@Injectable(as: IQRScanner)
class MockQRScanner implements IQRScanner {
  @override
  Future<Either<Failure, ScanResult>> scan() async {
    var completer = Completer<Either<Failure, ScanResult>>();
    completer.complete(Right(ScanResult(walletID: PrivateWalletID)));
    return completer.future;
  }
}
