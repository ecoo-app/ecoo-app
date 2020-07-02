import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:injectable/injectable.dart';

// TODO is this a use case or rather just data handling? I tend to data handlig...
@lazySingleton
class GetDefaultWallet extends UseCase<Wallet, NoParams> {
  final IWalletRepo repository;

  GetDefaultWallet({this.repository});

  Future<Either<Failure, Wallet>> call(NoParams params) async {
    return await repository.getWalletData('DR345GH67');
  }
}
