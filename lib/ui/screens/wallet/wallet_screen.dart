import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/base_view/viewstate.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_layout.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_view_model.dart';
import 'package:e_coupon/ui/core/widgets/amount_display.dart';
import 'package:e_coupon/ui/core/widgets/button/circular_icon_button.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

import '../../../injection.dart';

class WalletScreen extends StatelessWidget {
  final WalletEntity wallet;

  WalletScreen({Key key, @required this.wallet});

  _createButtons(bool isShop, BuildContext context, WalletViewModel vmodel) {
    if (isShop) {
      return [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircularIconButton(
                icon: Icons.call_received,
                text: I18n.of(context).privateWalletSend,
                onPressed: () {
                  vmodel.makePayment();
                },
              ),
              CircularIconButton(
                icon: Icons.attach_money,
                text: I18n.of(context).walletRedeem,
                onPressed: () {
                  Navigator.pushNamed(context, ClaimVerificationRoute,
                      arguments: vmodel.wallet.id);
                },
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
              CircularIconButton(
                icon: Icons.call_received,
                text: I18n.of(context).privateWalletRecieve,
                onPressed: () {
                  vmodel.makePaymentRequest();
                },
              ),
              CircularIconButton(
                icon: Icons.attach_money,
                text: I18n.of(context).privateWalletClaim,
                onPressed: () {
                  Navigator.pushNamed(context, ClaimVerificationRoute,
                      arguments: vmodel.wallet.id);
                },
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
    return WalletLayout(
      title: Text('my wallet'),
      body: BaseView<WalletViewModel>(
          model: getIt<WalletViewModel>(),
          disposeState: false,
          onModelReady: (vmodel) async => await vmodel.init(wallet),
          builder: (context, vmodel, child) {
            if (vmodel.wallet == null || vmodel.walletState is Loading) {
              return Center(child: ECProgressIndicator());
            } else {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  AmountDisplay(
                    isShopColor: vmodel.wallet.isShop,
                    isLoading: vmodel.amountState is Loading,
                    amount: vmodel.wallet.amountLabel,
                    currency: 'CHF',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  Center(
                    child: Text(
                      vmodel.walletState is Loaded
                          ? 'Wallet ${vmodel.wallet.id}'
                          : 'loading',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Center(
                    child: Text(vmodel.walletState is Loaded
                        ? '${vmodel.wallet.currency.label}'
                        : 'loading'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  ..._createButtons(vmodel.wallet.isShop, context, vmodel),
                  Expanded(
                    child: TransactionList(
                      isLoading: vmodel.transactionState is Loading,
                      context: context,
                      entries: vmodel.transactions,
                    ),
                  ),
                  Center(
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, TransactionOverviewRoute);
                      },
                      icon: Icon(Icons.folder_open),
                      label: Text(I18n.of(context).showAllTransactions),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
