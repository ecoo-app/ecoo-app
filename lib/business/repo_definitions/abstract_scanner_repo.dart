import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/core/failure.dart';

abstract class IScannerRepo {
  Future<Either<Failure, Transaction>> scanQR();
}
