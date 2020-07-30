import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/rhombus_button.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:e_coupon/ui/screens/register/register_scaffold.dart';
import 'package:e_coupon/ui/screens/register/register_wallet_type_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterWalletTypeScreen extends StatelessWidget {
  final RegisterWalletTypeScreenViewModel viewModel;

  RegisterWalletTypeScreen(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return RegisterScaffold(
      title: I18n.of(context).titleRegisterWalletTypeScreen,
      subhead: I18n.of(context).descriptionRegisterWalletTypeScreen,
      header: CustomHeader(
        closeIcon: Assets.close_svg,
        onClose: viewModel.back,
      ),
      content: Column(
        children: <Widget>[
          RhombusButton(
            text: I18n.of(context).privateRegisterWalletTypeScreen,
            private: true,
            onTap: viewModel.privateWalletSelected,
          ),
          RhombusButton(
            text: I18n.of(context).shopRegisterWalletTypeScreen,
            private: false,
            onTap: viewModel.shopWalletSelected,
          )
        ],
      ),
    );
  }
}
