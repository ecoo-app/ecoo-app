import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/verification_form.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:ecoupon_lib/models/verification_input_data.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class VerificationLoading extends ViewState {}

@injectable
class VerificationViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final IWalletRepo _walletRepo;
  final IWalletService _walletService;
  final IRouter _router;

  bool isShop;
  VerificationForm verificationInputs;
  Map<String, String> inputData = Map();

  VerificationViewModel(this._walletService, this._walletRepo, this._router);

  void loadVerificationInputs() async {
    setViewState(Loading());

    WalletEntity wallet = _walletService.getSelected();
    isShop = wallet.isShop;

    Either<Failure, VerificationForm> inputsOrFailure =
        await _walletRepo.getVerificationInputs(wallet.currency, wallet.isShop);

    inputsOrFailure.fold((failure) => setViewState(Error(failure)),
        (successInputs) {
      verificationInputs = successInputs;
      setViewState(Loaded());
    });
  }

  void onVerify(String successText) async {
    if (formKey.currentState.validate()) {
      setViewState(VerificationLoading());
      List<VerificationInputData> data = [];
      inputData.forEach((key, value) {
        data.add(VerificationInputData(key, value));
      });

      WalletEntity wallet = _walletService.getSelected();
      var verificationOrFaiure =
          await _walletRepo.verifyWallet(wallet.walletModel, data);

      verificationOrFaiure.fold((failure) => setViewState(Error(failure)),
          (success) {
        setViewState(Loaded());
        _router.pushNamed(SuccessRoute,
            arguments: SuccessScreenArguments(
                isShop: wallet.isShop,
                iconAssetPath: Assets.envelope_open_dollar_svg,
                text: successText));
      });
    }
  }
}
