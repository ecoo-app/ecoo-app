import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class VerificationLoading extends ViewState {}

@injectable
class VerificationViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  // final IWalletRepo _walletRepo;
  // final IWalletService _walletService;
  // final IRouter _router;

  bool isShop;
  Map<String, String> inputData = Map();

  // VerificationViewModel(this._walletService, this._walletRepo, this._router);

  void loadVerificationInputs() async {
    // setViewState(Loading());

    // WalletEntity wallet = _walletService.getSelected();
    // isShop = wallet.isShop;

    // Either<Failure, VerificationForm> inputsOrFailure =
    //     await _walletRepo.getVerificationInputs(wallet.currency, wallet.isShop);

    //     var inputs =

    // inputsOrFailure.fold((failure) => setViewState(Error(failure)),
    //     (successInputs) {
    //   verificationInputs = successInputs;
    //   setViewState(Loaded());
    // });
  }

  // TODO verification inputs are not generic anymore.

  void onVerify(String successText) async {
    // if (formKey.currentState.validate()) {
    //   setViewState(VerificationLoading());
    //   List<VerificationInputData> data = [];
    //   inputData.forEach((key, value) {
    //     data.add(VerificationInputData(key, value));
    //   });

    //   WalletEntity wallet = _walletService.getSelected();
    //   var verificationOrFaiure =
    //       await _walletRepo.verifyWallet(wallet.walletModel, data);

    //   verificationOrFaiure.fold((failure) => setViewState(Error(failure)),
    //       (success) {
    //     setViewState(Loaded());
    //     _router.pushNamed(SuccessRoute,
    //         arguments: SuccessScreenArguments(
    //             isShop: wallet.isShop,
    //             iconAssetPath: Assets.envelope_open_dollar_svg,
    //             text: successText));
    //   });
    // }
  }
}
