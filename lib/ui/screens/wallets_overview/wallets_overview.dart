import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';

import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:e_coupon/ui/core/widgets/wallet_card.dart';
import 'package:flutter/material.dart';

class WalletsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<WalletsViewModel>(
        model: getIt<WalletsViewModel>(),
        onModelReady: (vmodel) => vmodel.loadWallets(),
        builder: (context, vmodel, child) {
          // return vmodel.state == ViewStateEnum.Busy
          if (vmodel.viewState is Initial || vmodel.viewState is Loading) {
            return Center(child: ECProgressIndicator());
          } else if (vmodel.viewState is Loaded) {
            return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 30),
                children: <Widget>[
                  ...[
                    for (final wallet in vmodel.wallets) ...[
                      WalletCard(
                          wallet: wallet,
                          isActive: false,
                          onPressed: () {
                            Navigator.pushNamed(context, WalletDetailRoute,
                                arguments: wallet.id);
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
          }

          return Container();
        });
  }
}
