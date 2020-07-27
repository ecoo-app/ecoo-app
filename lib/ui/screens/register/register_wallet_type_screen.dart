import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/header/custom_header.dart';
import 'package:e_coupon/ui/screens/register/register_scaffold.dart';
import 'package:e_coupon/ui/screens/register/register_wallet_type_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
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
          WalletTypeWidget(
            text: I18n.of(context).privateRegisterWalletTypeScreen,
            private: true,
            onTap: viewModel.privateWalletSelected,
          ),
          WalletTypeWidget(
            text: I18n.of(context).shopRegisterWalletTypeScreen,
            private: false,
            onTap: viewModel.shopWalletSelected,
          )
        ],
      ),
    );
  }
}

class WalletTypeWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool private;

  const WalletTypeWidget({
    Key key,
    @required this.private,
    @required this.onTap,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var positionedImage = private
        ? Positioned(
            top: 109,
            left: 106,
            child: SvgPicture.asset(Assets.icon_arrow_right_svg))
        : Positioned(
            top: 56,
            left: 93,
            child: SvgPicture.asset(Assets.icon_arrow_right_svg));

    var positionedText = private
        ? Positioned(
            top: 59,
            left: 51,
            child: _text(text),
          )
        : Positioned(
            top: 90,
            left: 40,
            child: _text(text),
          );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: private ? Alignment.topLeft : Alignment.bottomRight,
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(private
                ? Assets.rectangle_green_svg
                : Assets.rectangle_blue_svg),
            positionedText,
            positionedImage
          ],
        ),
      ),
    );
  }

  Widget _text(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 35.0,
          color: ColorStyles.white,
          fontFamily: fontFamiliyPanam,
          fontWeight: fontWeightMedium),
    );
  }
}
