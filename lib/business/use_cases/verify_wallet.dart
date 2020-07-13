import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/verification_state.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@lazySingleton
class VerifyWallet extends UseCase<VerificationState, VerificationParams> {
  final IWalletRepo repository;

  VerifyWallet({this.repository});

  Future<Either<Failure, VerificationState>> call(
      VerificationParams params) async {
    return await repository.verifyWallet(
        params.walletId, params.verificationInputs);
  }
}

class VerificationParams extends Equatable {
  final String walletId;
  final List<String> verificationInputs;

  VerificationParams(
      {@required this.walletId, @required this.verificationInputs});

  @override
  List<Object> get props => [verificationInputs];
}
