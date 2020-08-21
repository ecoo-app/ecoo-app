import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/base_view/base_view.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/add_wallet_card.dart';
import 'package:e_coupon/ui/core/widgets/ec_progress_indicator.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:e_coupon/ui/core/widgets/wallet_card.dart';
import 'package:e_coupon/ui/screens/menu/menu_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class MenuScreen extends StatelessWidget {
  final MenuScreenViewModel viewModel;

  final TextStyle lightGrayTextStyle = const TextStyle(
      color: ColorStyles.brown_gray, fontSize: 12.0, letterSpacing: 0.0);

  final TextStyle grayTextStyle = const TextStyle(
      color: ColorStyles.bg_gray, fontSize: 12.0, letterSpacing: 0.0);

  MenuScreen(this.viewModel);

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        elevation: 0,
        child: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CustomHeader(
                closeIcon: Assets.close_svg,
                onClose: viewModel.close,
                headline: I18n.of(context).titleMenuScreen,
              ),
              Expanded(
                child: BaseView<MenuScreenViewModel>(
                  model: viewModel,
                  disposeState: false,
                  onModelReady: (m) async => await m.init(),
                  onModelDispose: (m) => m.dispose(),
                  builder: (context, model, child) {
                    return StreamBuilder<List<MenuItem>>(
                      stream: viewModel.wallets,
                      builder: (context, snapshot) {
                        // Display Wallets

                        if (snapshot.hasData && snapshot.data.isNotEmpty) {
                          return ListView.builder(
                            padding: const EdgeInsets.only(top: 25),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var item = snapshot.data[index];
                              if (item is WalletMenuItem) {
                                return WalletCard(
                                    wallet: item.walletEntity,
                                    isActive: viewModel.selected != null &&
                                            item.walletEntity.id ==
                                                viewModel.selected.id
                                        ? true
                                        : false,
                                    onPressed: () async {
                                      await viewModel.select(item.walletEntity);
                                    });
                              }
                              if (item is NetworkErrorMenuItem) {
                                return Icon(Icons.signal_wifi_off);
                              }
                              if (item is AddWalletMenutItem) {
                                return AddWalletCard();
                              }
                              if (item is OnboardingMenuItem) {
                                return MenuItemWidget(
                                  text: I18n.of(context).onboardingMenuScreen,
                                  onTap: viewModel.onboarding,
                                );
                              }
                              if (item is FaqMenuItem) {
                                return MenuItemWidget(
                                  text: I18n.of(context).faqhelpMenuScreen,
                                  onTap: () => print('faq'),
                                );
                              }
                              if (item is PrivacyPolicyMenuItem) {
                                return MenuItemWidget(
                                  text:
                                      I18n.of(context).privacyPolicyMenuScreen,
                                  onTap: () async {
                                    await launchUrl(
                                        I18n.of(context).dataPolicyUrl);
                                  },
                                );
                              }
                              // Empty List
                              return Container();
                            },
                          );
                        } else {
                          // Empty State
                          return Container(
                            child: Center(
                              child: ECProgressIndicator(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),

              // Footer
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(I18n.of(context).appversionMenuScreen,
                            style: lightGrayTextStyle),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          viewModel.appVersion,
                          style: grayTextStyle,
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(I18n.of(context).tezosFoundationUrl);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text('Powered by', style: lightGrayTextStyle),
                          SizedBox(width: 5),
                          Text('Tezos', style: grayTextStyle),
                          SizedBox(
                            width: 2,
                          ),
                          SvgPicture.asset(
                            Assets.tezos_svg,
                            fit: BoxFit.scaleDown,
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MenuItemWidget({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            alignment: Alignment.bottomLeft,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            height: 1,
            color: ColorStyles.bg_light_gray,
          )
        ],
      ),
    );
  }
}
