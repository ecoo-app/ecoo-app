import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';

import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:e_coupon/ui/core/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WalletsOverviewScreen extends StatelessWidget {
  List<Widget> createItems(
      WalletsViewModel vmodel, List<WalletEntity> wallets) {
    List<Widget> widgets = [];
    for (final wallet in wallets) {
      widgets.add(WalletCard(
          wallet: wallet,
          isActive: wallet.id == vmodel.getSelected().id ? true : false,
          onPressed: () async {
            await vmodel.setSelected(wallet);
          }));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletsViewModel>(
        model: getIt<WalletsViewModel>(),
        builder: (context, vmodel, child) {
          return Container(
            height: 500,
            child: FutureBuilder<Either<Failure, List<WalletEntity>>>(
                initialData: vmodel.wallets,
                future: vmodel.futureWallets,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('none');
                    case ConnectionState.waiting:
                      var view;
                      snapshot.data.fold((failure) {
                        view = Container();
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          ErrorToast(failure: failure).create(context)
                            ..show(context);
                        });
                      },
                          (wallets) => view = ListView(
                                  shrinkWrap: true,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  children: <Widget>[
                                    Center(child: ECProgressIndicator()),
                                    ...createItems(vmodel, wallets),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      alignment: Alignment.center,
                                      child: FlatButton.icon(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, RegisterWalletTypeRoute);
                                        },
                                        icon: Icon(Icons.add_circle_outline),
                                        label: Text(I18n.of(context).addWallet),
                                      ),
                                    )
                                  ]));
                      return view;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      var view;
                      snapshot.data.fold((failure) {
                        print(failure);
                        view = Container();
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          ErrorToast(failure: failure).create(context)
                            ..show(context);
                        });
                      },
                          (wallets) => view = ListView(
                                  shrinkWrap: true,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  children: <Widget>[
                                    FutureBuilder<bool>(
                                      future: vmodel.isConnected,
                                      builder: (context, snapsho) {
                                        if (snapsho.connectionState ==
                                            ConnectionState.done) {
                                          if (snapsho.data) {
                                            return Container();
                                          } else {
                                            return Icon(Icons.signal_wifi_off);
                                          }
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                    ...createItems(vmodel, wallets),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      alignment: Alignment.center,
                                      child: FlatButton.icon(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, RegisterWalletTypeRoute);
                                        },
                                        icon: Icon(Icons.add_circle_outline),
                                        label: Text(I18n.of(context).addWallet),
                                      ),
                                    )
                                  ]));
                      return view;
                    default:
                      return Text('default');
                  }
                }),
          );
        });
  }
}
