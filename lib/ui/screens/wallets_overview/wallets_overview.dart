import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/view_state/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';

import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:e_coupon/ui/shared/ec_progress_indicator.dart';
import 'package:e_coupon/ui/shared/wallet_card.dart';
import 'package:flutter/material.dart';

class WalletsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wallets'),
          backgroundColor: Colors.cyan,
        ),
        body: BaseView<WalletsViewModel>(
            model: getIt<WalletsViewModel>(),
            onModelReady: (vmodel) => vmodel.loadWallets(),
            builder: (context, vmodel, child) {
              // return vmodel.state == ViewStateEnum.Busy
              if (vmodel.viewState is Initial || vmodel.viewState is Loading)
                return Center(child: ECProgressIndicator());
              else if (vmodel.viewState is Loaded)
                return ListView.builder(
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
                );
            }));
  }
}
