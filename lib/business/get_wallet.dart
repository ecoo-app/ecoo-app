import 'package:equatable/equatable.dart';

import 'abstract_wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:meta/meta.dart';

import 'core/abstract_use_case.dart';
import 'entities/wallet.dart';

class GetWallet extends UseCase<Wallet, Params> {
  final IWalletRepo repository;

  GetWallet({this.repository});

  Future<Either<Failure, Wallet>> call(Params params) async {
    return await repository.getWalletData(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({@required this.id});

  @override
  List<Object> get props => [id];
}
