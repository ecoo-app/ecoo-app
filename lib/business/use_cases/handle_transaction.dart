import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/entities/transaction_state.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@lazySingleton
class HandleTransaction extends UseCase<TransactionState, TransactionParams> {
  final IWalletRepo repository;

  HandleTransaction({this.repository});

  Future<Either<Failure, TransactionState>> call(
      TransactionParams params) async {
    return await repository.handleTransaction(
        params.senderId, params.recieverId, params.amount);
  }
}

class TransactionParams extends Equatable {
  final String senderId;
  final String recieverId;
  final double amount;

  TransactionParams(
      {@required this.senderId,
      @required this.recieverId,
      @required this.amount});

  @override
  List<Object> get props => [senderId, recieverId, amount];
}
