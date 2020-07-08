import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/screens/transaction_screens/payment/success_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../injection.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
        child: Scaffold(
            body: BaseView<SuccessViewModel>(
                model: getIt<SuccessViewModel>(), // TODO injectable
                onModelReady: (vmodel) => vmodel.init(),
                builder: (_, vmodel, __) {
                  if (vmodel.viewState is DurationEnd) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          WalletDetailRoute, (route) => false);
                    });
                  }
                  return Text('success');
                })));
  }
}
