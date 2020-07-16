import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/form_generator.dart';
import 'package:e_coupon/ui/core/widgets/main_layout.dart';
import 'package:e_coupon/ui/screens/verification/verification_view_model.dart';
import 'package:flutter/cupertino.dart';

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: Text('Verification'),
      body: BaseView<ClaimVerificationViewModel>(
          model: getIt<ClaimVerificationViewModel>(),
          onModelReady: (vmodel) => vmodel.loadVerificationInputs(),
          builder: (context, vmodel, child) {
            return Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: vmodel.viewState is Loading
                    ? ECProgressIndicator()
                    : Column(children: <Widget>[
                        FormGenerator(vmodel.verificationInputs)
                        // Text('Inputs'),
                      ]));
          }),
    );
  }
}
