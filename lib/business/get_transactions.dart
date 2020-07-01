import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'abstract_wallet_repo.dart';
import 'core/abstract_use_case.dart';
import 'entities/transaction.dart';

@lazySingleton
class GetTransactions extends UseCase<List<Transaction>, TransactionParams> {
  final IWalletRepo repository;

  GetTransactions({this.repository});

  Future<Either<Failure, List<Transaction>>> call(
      TransactionParams params) async {
    return await repository.getWalletTransactions(params.id, {});
  }
}

class TransactionParams extends Equatable {
  final String id;
  final filterOrPagination;

  TransactionParams({@required this.id, this.filterOrPagination});

  @override
  List<Object> get props => [id, filterOrPagination];
}
