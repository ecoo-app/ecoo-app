import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/button/flat_secondary_button.dart';
import 'package:e_coupon/ui/core/widgets/button/primary_button.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:e_coupon/ui/screens/register/register_scaffold.dart';
import 'package:e_coupon/ui/screens/register/register_verify_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterVerifyScreen extends StatelessWidget {
  final RegisterVerifyScreenViewModel viewModel;

  const RegisterVerifyScreen(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return RegisterScaffold(
      header: CustomHeader(
        closeIcon: Assets.back_svg,
        onClose: viewModel.close,
      ),
      title: I18n.of(context).titleRegisterVerifyScreen,
      subhead: I18n.of(context).descriptionRegisterVerifyScreen,
      content: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: PrimaryButton(
              text: I18n.of(context).buttonTextNexOnboardingScreen,
              onPressed: viewModel.verify,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FlatSecondaryButton(
            textColor: ColorStyles.red,
            onPressed: viewModel.verifyLater,
            text: I18n.of(context).buttonTextSkipOnboardingScreen,
          )
        ],
      ),
    );
  }
}
