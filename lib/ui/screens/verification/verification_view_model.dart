import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/city_of_origin.dart';
import 'package:e_coupon/data/repos/verification_repo.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/origin_service.dart';
import 'package:e_coupon/ui/core/services/profile_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/screens/verification/info_screen.dart';
import 'package:e_coupon/ui/screens/verification/verification_input_data.dart';
import 'package:ecoupon_lib/common/verification_stage.dart';
import 'package:ecoupon_lib/models/address_auto_completion_result.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

class VerificationLoading extends ViewState {}

@injectable
class VerificationViewModel extends BaseViewModel {
  final IWalletService _walletService;
  final IProfileService _profileService;
  final IRouter _router;
  final IVerificationRepo _verificationRepo;
  final IOriginService _originService;

  VerificationInputData _inputData = VerificationInputData();
  final formKey = GlobalKey<FormState>();

  VerificationViewModel(this._walletService, this._profileService, this._router,
      this._verificationRepo, this._originService);

  VerificationInputData get inputData => _inputData;

  bool get isShop => _walletService.getSelected()?.isShop ?? false;

  Future<List<AddressAutoCompletionResult>> fetchAutoCompletions(
      String pattern) async {
    List<AddressAutoCompletionResult> result;
    Either<Failure, List<AddressAutoCompletionResult>> address;

    if (isShop) {
      address = await _verificationRepo.fetchAutoCompletions(
          target: AddressAutoCompletionTarget.company, partialAddress: pattern);
    } else {
      address = await _verificationRepo.fetchAutoCompletions(
          target: AddressAutoCompletionTarget.user, partialAddress: pattern);
    }

    address.fold((failure) {
      result = [];
      setViewState(Error(failure));
    }, (addressList) => result = addressList);
    return result;
  }

  Future<List<CityOfOrigin>> fetchCityOfOriginSuggestions(
      String pattern) async {
    List<CityOfOrigin> origins;

    var originsOrFailure =
        await this._originService.cityAutocompletions(pattern);

    originsOrFailure.fold((failure) => setViewState(Error(failure)),
        (success) => origins = success);

    return origins;
  }

  Future<void> onVerify(
      VerificationInputData value, BuildContext context) async {
    if (formKey.currentState.validate() && value.isValid(isShop)) {
      setViewState(Loading());

      var walletId = _walletService.getSelected().id;
      var profile = isShop
          ? inputData.toCompanyEntity(walletId)
          : inputData.toProfileEntity(walletId);

      try {
        var result = await _profileService.create(profile);

        if (result != null) {
          setViewState(Loaded());

          if (isShop) {
            if (inputData.hasUID &&
                result.verificationStage == VerificationStage.pendingPIN) {
              await _toInfoScreen(VerificationInfoScreenArguments(
                  I18n.of(context).verifyShopSuccessHeadline,
                  I18n.of(context).verifyShopSuccessDescription));
              return;
            }

            if (result.verificationStage == VerificationStage.notMatched &&
                !inputData.hasUID) {
              await _toInfoScreen(VerificationInfoScreenArguments(
                  I18n.of(context).verifyNoUidSubTitle,
                  I18n.of(context).verifyNoUidInfo));
              return;
            }
          }

          if (result.verificationStage == VerificationStage.notMatched) {
            await _toInfoScreen(VerificationInfoScreenArguments(
                I18n.of(context).verifyNoUidSubTitle,
                I18n.of(context).verifyFormErrorVerification));
            return;
          }

          if (result.verificationStage == VerificationStage.maxClaimsReached) {
            await _toInfoScreen(VerificationInfoScreenArguments(
                I18n.of(context).verifyNoUidSubTitle,
                I18n.of(context).verifyMaxClaimsReached));
            return;
          }

          await _toPinVerification();
        }
      } catch (failure) {
        setViewState(Error((failure as Failure)));
      }
    }
  }

  Future<void> _toPinVerification() async {
    _originService.closeClient();
    await _router.pushNamed(VerifyPinRoute);
  }

  void _toInfoScreen(VerificationInfoScreenArguments arguments) async {
    _originService.closeClient();
    await _router.pushNamed(InfoRoute, arguments: arguments);
  }

  void resetViewState() {
    setViewState(Initial());
  }
}
