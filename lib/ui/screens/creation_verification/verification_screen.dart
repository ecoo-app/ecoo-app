import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/form_generator.dart';
import 'package:e_coupon/ui/core/widgets/layout/main_layout.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/screens/creation_verification/verification_view_model.dart';
import 'package:flutter/cupertino.dart';

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: I18n.of(context).titleFormClaimVerification,
      body: BaseView<ClaimVerificationViewModel>(
          model: getIt<ClaimVerificationViewModel>(),
          onModelReady: (vmodel) => vmodel.loadVerificationInputs(),
          builder: (context, vmodel, child) {
            return vmodel.viewState is Loading
                ? ECProgressIndicator()
                : Column(children: <Widget>[
                    Text(vmodel.verificationInputs.title),
                    FormGenerator(vmodel.verificationInputs.inputs),
                    PrimaryButton(
                      text: I18n.of(context).buttonFormClaimVerification,
                      onPressed: () =>
                          Navigator.pushNamed(context, WalletDetailRoute),
                    ),
                  ]);
          }),
    );
  }
}
