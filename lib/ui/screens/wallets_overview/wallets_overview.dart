import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view.dart';
import 'package:e_coupon/ui/core/router.dart';
import 'package:e_coupon/ui/core/viewstate.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
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
              return vmodel.state == ViewStateEnum.Busy
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 2,
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
