import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/verification_form.dart';
import 'package:e_coupon/business/use_cases/get_verification_inputs.dart';
import 'package:e_coupon/business/use_cases/verify_claim.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClaimVerificationViewModel extends BaseViewModel {
  VerificationForm verificationInputs;
  final VerifyClaim _verifyClaim;
  final GetVerificationInputs _getVerificationInputs;

  ClaimVerificationViewModel(this._verifyClaim, this._getVerificationInputs);

  void loadVerificationInputs() async {
    setViewState(Loading());

    Either<Failure, VerificationForm> inputsOrFailure =
        await _getVerificationInputs(
            VerificationInputsParams(currencyId: 'wetzicoin', isShop: true));
    inputsOrFailure.fold(
        (failure) => print('FAILURE'), (inputs) => verificationInputs = inputs);

    setViewState(Loaded());
  }
}
