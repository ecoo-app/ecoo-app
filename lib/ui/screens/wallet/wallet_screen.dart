import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/error_toast.dart';
import 'package:e_coupon/ui/screens/menu/menu_screen.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_view_model.dart';
import 'package:e_coupon/ui/core/widgets/amount_display.dart';
import 'package:e_coupon/ui/core/widgets/button/circular_icon_button.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/screens/wallet/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';

import '../../../injection.dart';

@injectable
class WalletScreen extends StatelessWidget {
  _createButtons(bool isShop, BuildContext context, WalletViewModel vmodel) {
    if (isShop) {
      return [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CircularIconButton(
                    iconAsset: Assets.shop_envelope_open_dollar_svg,
                    text: I18n.of(context).privateWalletSend,
                    onPressed: vmodel.makePayment),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CircularIconButton(
                    iconAsset: Assets.shop_send_money_svg,
                    text: I18n.of(context).walletRedeem,
                    onPressed: () => vmodel
                        .onRedeem(I18n.of(context).waitForVerificationError)),
              )
            ]),
        Container(
          margin: const EdgeInsets.only(top: 25),
          child: PrimaryButton(
              text: I18n.of(context).walletCashier,
              onPressed: vmodel.makePaymentRequest),
        ),
      ];
    } else {
      return [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CircularIconButton(
                    iconAsset: Assets.private_recieve_money_svg,
                    text: I18n.of(context).privateWalletRecieve,
                    onPressed: vmodel.makePaymentRequest),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CircularIconButton(
                    iconAsset: Assets.private_claim_money_svg,
                    text: I18n.of(context).privateWalletClaim,
                    onPressed: vmodel.onClaim),
              )
            ]),
        Container(
          margin: const EdgeInsets.only(top: 25),
          child: PrimaryButton(
              text: I18n.of(context).privateWalletPay,
              onPressed: vmodel.makePayment),
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
              if (vmodel.viewState is Error) {
                Error error = vmodel.viewState;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ErrorToast(failure: error.failure).create(context)
                    ..show(context);
                  vmodel.resetViewState();
                });
              }
              return Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 53),
                          child: IconButton(
                            key: Key('menu_button'),
                            icon: SvgPicture.asset(Assets.menu_svg),
                            onPressed: Scaffold.of(context).openDrawer,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: AmountDisplay(
                          isShopColor: vmodel.wallet.isShop,
                          isLoading: vmodel.amountState is Loading,
                          amount: vmodel.wallet.amountLabel,
                          symbol: vmodel.wallet.currency.symbol,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                  vmodel.walletState is Loaded
                                      ? '${vmodel.wallet.currency.label}'
                                      : 'loading',
                                  textAlign: TextAlign.center),
                              Text(
                                vmodel.walletState is Loaded
                                    ? 'Wallet ${vmodel.wallet.id}'
                                    : 'loading',
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.center,
                              ),
                              InkWell(
                                  child:
                                      SvgPicture.asset(Assets.icon_qrcode_svg),
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(WalletQROverlayRoute)),
                              SizedBox(
                                height: 16,
                              ),
                              ..._createButtons(
                                  vmodel.wallet.isShop, context, vmodel),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            I18n.of(context).walletTimeline,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(fontWeight: fontWeightBold)),
                          ),
                        ),
                        FutureBuilder(
                          future: vmodel.isConnected,
                          builder: (context, snapshot) {
                            if (snapshot.data != null && snapshot.data) {
                              return Expanded(
                                child: NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                      vmodel.loadMore();
                                    }
                                    // Return true to cancel the notification bubbling.
                                    // Return false (or null) to allow the notification to continue to be dispatched to further ancestors.
                                    return true;
                                  },
                                  child: TransactionList(
                                    transactions: vmodel.transactionStream,
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 8),
                                child: Icon(Icons.signal_wifi_off),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
