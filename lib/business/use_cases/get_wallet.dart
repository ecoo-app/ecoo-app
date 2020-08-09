import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:meta/meta.dart';

@lazySingleton
class GetWallet extends UseCase<WalletEntity, WalletParams> {
  final IWalletRepo repository;

  GetWallet({this.repository});

  Future<Either<Failure, WalletEntity>> call(WalletParams params) async {
    return await repository.getWalletData(params.id);
  }
}

class WalletParams extends Equatable {
  final String id;

  WalletParams({@required this.id});

  @override
  List<Object> get props => [id];
}
