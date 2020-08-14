import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/profile_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/screens/verification/verification_input_data.dart';
import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

class VerificationLoading extends ViewState {}

@injectable
class VerificationViewModel extends BaseViewModel {
  final IWalletService _walletService;
  final IProfileService _profileService;
  final IRouter _router;

  VerificationInputData _inputData = VerificationInputData();
  final formKey = GlobalKey<FormState>();

  VerificationViewModel(
      this._walletService, this._profileService, this._router);

  VerificationInputData get inputData => _inputData;

  bool get isShop => _walletService.getSelected()?.isShop ?? false;

  Future<void> onVerify(String successText) async {
    if (formKey.currentState.validate()) {
      setViewState(Loading());

      var profile =
          isShop ? inputData.toCompanyEntity() : inputData.toProfileEntity();

      try {
        var result = await _profileService.create(profile);

        if (result != null) {
          if (result.verificationStage == VerificationStage.notMatched) {
            // TODO Show Error Message
            print('view model no good');
            setViewState(Error(MessageFailure(
                'Deine Angaben konnten nicht verifiziert werden. Bitte trete mit der Gemeinde in Kontakt.')));
            return;
          }

          await _router.pushNamed(VerifyPinRoute);
          setViewState(Loaded());
        }
      } catch (failure) {
        print('view model error $failure');
        // setViewState(failure);
        setViewState(Error((failure as Failure)));
      }
    }
  }
}