import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';

import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:e_coupon/ui/core/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WalletsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<WalletsViewModel>(
        model: getIt<WalletsViewModel>(),
        onModelReady: (vmodel) => vmodel.loadWallets(),
        builder: (context, vmodel, child) {
          if (vmodel.viewState is Error) {
            Error error = vmodel.viewState;
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ErrorToast(failure: error.failure).create(context)..show(context);
            });
          }
          return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: <Widget>[
                vmodel.viewState is Loading
                    ? Center(child: ECProgressIndicator())
                    : Container(),
                ...[
                  for (final wallet in vmodel.wallets) ...[
                    WalletCard(
                        wallet: wallet,
                        isActive: false,
                        onPressed: () {
                          Navigator.pushNamed(context, WalletDetailRoute,
                              arguments: wallet);
                        })
                  ],
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, WalletCreationRoute);
                      },
                      icon: Icon(Icons.add_circle_outline),
                      label: Text(I18n.of(context).addWallet),
                    ),
                  )
                ],
              ]);
        });
  }
}
