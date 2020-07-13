import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@lazySingleton
class GetAllWallets extends UseCase<List<Wallet>, AllWalletParams> {
  final IWalletRepo repository;

  GetAllWallets({this.repository});

  Future<Either<Failure, List<Wallet>>> call(AllWalletParams params) async {
    return await repository.getWallets(params.userIdentifier);
  }
}

class AllWalletParams extends Equatable {
  final String userIdentifier;

  AllWalletParams({@required this.userIdentifier});

  @override
  List<Object> get props => [userIdentifier];
}
