import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/verification_input.dart';
import 'package:e_coupon/business/entities/verification_state.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@lazySingleton
class GetVerificationInputs
    extends UseCase<List<VerificationInput>, VerificationInputsParams> {
  final IWalletRepo repository;

  GetVerificationInputs({this.repository});

  Future<Either<Failure, List<VerificationInput>>> call(
      VerificationInputsParams params) async {
    return await repository.getVerificationInputs(
        params.currencyId, params.isShop);
  }
}

class VerificationInputsParams extends Equatable {
  final String currencyId;
  final bool isShop;

  VerificationInputsParams({@required this.currencyId, @required this.isShop});

  @override
  List<Object> get props => [currencyId, isShop];
}
