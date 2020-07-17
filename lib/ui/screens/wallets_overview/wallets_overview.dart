import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/layout/headerless_layout.dart';

import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:e_coupon/ui/core/widgets/wallet_card.dart';
import 'package:flutter/material.dart';

class WalletsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HeaderlessLayout(
        title: 'Wallets',
        body: BaseView<WalletsViewModel>(
            model: getIt<WalletsViewModel>(),
            onModelReady: (vmodel) => vmodel.loadWallets(),
            builder: (context, vmodel, child) {
              // return vmodel.state == ViewStateEnum.Busy
              if (vmodel.viewState is Initial || vmodel.viewState is Loading)
                return Center(child: ECProgressIndicator());
              else if (vmodel.viewState is Loaded)
                return Column(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: vmodel.wallets.length,
                      itemBuilder: (context, i) {
                        final wallet = vmodel.wallets[i];
                        return WalletCard(
                          wallet: wallet,
                          onPressed: () {
                            Navigator.pushNamed(context, WalletDetailRoute,
                                arguments: wallet.id);
                          },
                        );
                      },
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        // todo create new wallet -> verification needs new wallet id -> put wallet view model as app view model
                        Navigator.pushNamed(context, WalletCreationRoute);
                      },
                      icon: Icon(Icons.add_circle_outline),
                      label: Text(I18n.of(context).addWallet),
                    )
                  ],
                );
            }));
  }
}
