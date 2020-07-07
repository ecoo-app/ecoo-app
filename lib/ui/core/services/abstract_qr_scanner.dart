import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:meta/meta.dart';

// maybe extend transaction?
class ScannedResult {
  final String walletID;
  final double amount;

  ScannedResult({@required this.walletID, this.amount});
}

abstract class IQRScanner {
  Future<Either<Failure, ScannedResult>> scan();
}
