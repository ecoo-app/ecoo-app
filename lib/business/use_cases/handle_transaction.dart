import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:ecoupon_lib/models/transaction.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@lazySingleton
class HandleTransaction extends UseCase<Transaction, TransactionParams> {
  final IWalletRepo repository;

  HandleTransaction({this.repository});

  Future<Either<Failure, Transaction>> call(TransactionParams params) async {
    return await repository.handleTransaction(
        params.sender, params.reciever, params.amount);
  }
}

class TransactionParams extends Equatable {
  final WalletEntity sender;
  final WalletEntity reciever;
  final int amount;

  TransactionParams(
      {@required this.sender, @required this.reciever, @required this.amount});

  @override
  List<Object> get props => [sender, reciever, amount];
}
