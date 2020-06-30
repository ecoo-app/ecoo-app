import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'abstract_wallet_repo.dart';
import 'core/abstract_use_case.dart';
import 'entities/wallet.dart';

class GetAllWallets extends UseCase<List<Wallet>, Params> {
  final IWalletRepo repository;

  GetAllWallets({this.repository});

  Future<Either<Failure, List<Wallet>>> call(Params params) async {
    return await repository.getWallets(params.userIdentifier);
  }
}

class Params extends Equatable {
  final String userIdentifier;

  Params({@required this.userIdentifier});

  @override
  List<Object> get props => [userIdentifier];
}
