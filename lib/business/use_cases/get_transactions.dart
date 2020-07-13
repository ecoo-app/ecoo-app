import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/entities/transaction_record.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@lazySingleton
class GetTransactions
    extends UseCase<List<TransactionRecord>, GetTransactionParams> {
  final IWalletRepo repository;

  GetTransactions({this.repository});

  Future<Either<Failure, List<TransactionRecord>>> call(
      GetTransactionParams params) async {
    return await repository.getWalletTransactions(params.id, {});
  }
}

class GetTransactionParams extends Equatable {
  final String id;
  final filterOrPagination;

  GetTransactionParams({@required this.id, this.filterOrPagination});

  @override
  List<Object> get props => [id, filterOrPagination];
}
