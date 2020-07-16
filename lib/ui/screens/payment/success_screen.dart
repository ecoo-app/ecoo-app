import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/screens/payment/success_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../injection.dart';

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
                      // Navigator.of(context)
                      //     .popUntil(ModalRoute.withName(WalletDetailRoute));
                      // TODO which is correct?
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          WalletDetailRoute, (_) => false);
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     WalletDetailRoute,
                      //     ModalRoute.withName(WalletDetailRoute));
                      // Navigator.pushNamed(context, WalletDetailRoute);
                    });
                  }
                  return Center(
                      child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.blue, Colors.red])),
                    child: Center(
                      child: Text(
                        'Success!',
                        style: TextStyle(
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ));
                })));
  }
}
