import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/entities/transaction.dart';
import 'package:e_coupon/business/repo_definitions/abstract_scanner_repo.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ScanQR extends UseCase<Transaction, NoParams> {
  final IScannerRepo repository;

  ScanQR({this.repository});

  Future<Either<Failure, Transaction>> call(NoParams params) async {
    return await repository.scanQR();
  }
}
