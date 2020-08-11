import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/screens/verification/verification_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerificationScreen extends StatelessWidget {
  final VerificationViewModel _viewModel;

  VerificationScreen(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return BaseView<VerificationViewModel>(
        model: this._viewModel,
        onModelReady: (vmodel) => vmodel.loadVerificationInputs(),
        builder: (context, vmodel, child) {
          return MainLayout(
            isShop: vmodel.isShop,
            title: I18n.of(context).titleFormClaimVerification,
            body: (() {
              if (vmodel.viewState is Loading) {
                return ECProgressIndicator();
              } else if (vmodel.viewState is Error) {
                Error error = vmodel.viewState;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ErrorToast(failure: error.failure).create(context)
                    ..show(context);
                });
                return Container();
              } else {
                return Column(children: <Widget>[
                  Text('TODO')
                  // Text(vmodel.verificationInputs.isShop
                  //     ? I18n.of(context).verificationShopFormTitle
                  //     : I18n.of(context).verificationPrivateFormTitle),
                  // FormGenerator(
                  //   inputs: vmodel.verificationInputs.inputs,
                  //   inputData: vmodel.inputData,
                  //   formKey: vmodel.formKey,
                  // ),
                ]);
              }
            }()),
            bottom: Container(
              margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: PrimaryButton(
                isLoading: vmodel.viewState is VerificationLoading,
                text: I18n.of(context).buttonFormClaimVerification,
                onPressed: () =>
                    vmodel.onVerify(I18n.of(context).verificationSend),
              ),
            ),
          );
        });
  }
}
