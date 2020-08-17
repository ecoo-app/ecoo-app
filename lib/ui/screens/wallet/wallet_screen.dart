import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/screens/menu/menu_screen.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_view_model.dart';
import 'package:e_coupon/ui/core/widgets/amount_display.dart';
import 'package:e_coupon/ui/core/widgets/button/circular_icon_button.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/screens/wallet/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';

import '../../../injection.dart';

@injectable
class WalletScreen extends StatelessWidget {
  _createButtons(bool isShop, BuildContext context, WalletViewModel vmodel) {
    if (isShop) {
      return [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CircularIconButton(
                  iconAsset: Assets.shop_envelope_open_dollar_svg,
                  text: I18n.of(context).privateWalletSend,
                  onPressed: () {
                    vmodel.makePayment();
                  },
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CircularIconButton(
                  iconAsset: Assets.shop_send_money_svg,
                  text: I18n.of(context).walletRedeem,
                  onPressed: () {
                    vmodel.onRedeem();
                    ;
                  },
                ),
              )
            ]),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          child: PrimaryButton(
            text: I18n.of(context).walletCashier,
            onPressed: () {
              vmodel.makePaymentRequest();
            },
          ),
        ),
      ];
    } else {
      return [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CircularIconButton(
                  iconAsset: Assets.private_recieve_money_svg,
                  text: I18n.of(context).privateWalletRecieve,
                  onPressed: () {
                    vmodel.makePaymentRequest();
                  },
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CircularIconButton(
                  iconAsset: Assets.private_claim_money_svg,
                  text: I18n.of(context).privateWalletClaim,
                  onPressed: () {
                    vmodel.onClaim();
                    // Navigator.pushNamed(context, VerificationRoute,
                    //     arguments: vmodel.wallet.id);
                  },
                ),
              )
            ]),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          child: PrimaryButton(
            text: I18n.of(context).privateWalletPay,
            onPressed: () {
              vmodel.makePayment();
            },
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getIt.get<MenuScreen>(),
      body: BaseView<WalletViewModel>(
          model: getIt<WalletViewModel>(),
          disposeState: false,
          onModelReady: (vmodel) async => await vmodel.init(),
          builder: (context, vmodel, child) {
            if (vmodel.wallet == null || vmodel.walletState is Loading) {
              return Center(child: ECProgressIndicator());
            } else {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 25),
                        child: IconButton(
                          key: Key('menu_button'),
                          icon: SvgPicture.asset(Assets.menu_svg),
                          iconSize: LayoutStyles.iconSize,
                          onPressed: Scaffold.of(context).openDrawer,
                        ),
                      ),
                      AmountDisplay(
                        isShopColor: vmodel.wallet.isShop,
                        isLoading: vmodel.amountState is Loading,
                        amount: vmodel.wallet.amountLabel,
                        symbol: 'CHF',
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                          ),
                          Center(
                            child: Text(vmodel.walletState is Loaded
                                ? '${vmodel.wallet.currency.label}'
                                : 'loading'),
                          ),
                          Center(
                            child: Text(
                              vmodel.walletState is Loaded
                                  ? 'Wallet ${vmodel.wallet.id}'
                                  : 'loading',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          InkWell(
                              child: SvgPicture.asset(Assets.icon_qrcode_svg),
                              onTap: () => Navigator.of(context)
                                  .pushNamed(WalletQROverlayRoute)),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                          ),
                          ..._createButtons(
                              vmodel.wallet.isShop, context, vmodel),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              I18n.of(context).walletTimline,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(fontWeight: fontWeightBold)),
                            ),
                          ),
                          FutureBuilder(
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
                          Expanded(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                                  vmodel.loadMore();
                                }
                                // Return true to cancel the notification bubbling.
                                // Return false (or null) to allow the notification to continue to be dispatched to further ancestors.
                                return true;
                              },
                              child: TransactionList(
                                isLoading: vmodel.transactionState is Loading,
                                context: context,
                                entries: vmodel.transactions,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
