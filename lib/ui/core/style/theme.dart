import 'package:flutter/material.dart';

const FontWeight fontWeightMedium = FontWeight.w500;
const FontWeight fontWeightBold = FontWeight.w800;
const FontWeight fontWeightRegular = FontWeight.w400;

const String fontFamiliyPanam = 'NewPanam';

ThemeData generalTheme = ThemeData(
  accentColor: ColorStyles.bg_gray,
  primaryColor: ColorStyles.black,
  scaffoldBackgroundColor: ColorStyles.white,
  backgroundColor: ColorStyles.white,
  textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 75.0,
          fontWeight: fontWeightBold,
          fontFamily: fontFamiliyPanam,
          color: ColorStyles.black),
      headline2: TextStyle(
          fontSize: 50.0,
          fontWeight: fontWeightBold,
          fontFamily: fontFamiliyPanam,
          color: ColorStyles.black),
      headline3: TextStyle(
          fontSize: 25.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam,
          color: ColorStyles.black),
      headline4: TextStyle(
          fontSize: 25.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam),
      headline5: TextStyle(
          fontSize: 20.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam),
      button: TextStyle(
          fontSize: 25.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam),
      bodyText1: TextStyle(
          fontSize: 15.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam),
      bodyText2: TextStyle(
          fontSize: 15.0,
          fontWeight: fontWeightRegular,
          fontFamily: fontFamiliyPanam),
      caption: TextStyle(
          fontSize: 12.0,
          fontWeight: fontWeightRegular,
          fontFamily: fontFamiliyPanam)),
);

class ColorStyles {
  static const Color white = Color(0xFFFFFFFF);
  static const Color bg_white_9 = Color(0xE6FFFFFF);
  static const Color bg_light_gray = Color(0xFFF7F7F7);
  static const Color brown_gray = Color(0xFF979797);
  static const Color bg_gray = Color(0xFF575757);
  static const Color black = Color(0xFF373737);
  static const Color bg_transparent = Color(0x40000000);

  static const Color blue = Color(0xFF3979FF);
  static const Color green = Color(0xFF45DEA3);
  static const Color purple = Color(0xFF9774FF);
  static const Color red = Color(0xFFFF5F5F);
  static const Color pink = Color(0xFFFF96E3);
}

class LayoutStyles {
  static const double iconSize = 23;

  static const double spacing_xs = 4;
  static const double spacing_s = 8;
  static const double spacing_m = 25.0;
}

class Assets {
  static const close_svg = 'assets/images/close.svg';
  static const back_svg = 'assets/images/back.svg';
  static const tezos_svg = 'assets/images/tezos.svg';
  static const keyboard_purpe_svg = 'assets/images/icon_keyboard_purple.svg';
  static const apple_icon_svg = 'assets/images/apple_icon.svg';
  static const google_icon_svg = 'assets/images/google_icon.svg';
  static const menu_svg = 'assets/images/stream.svg';
  static const qr_code_frame_svg = 'assets/images/qr_code_frame.svg';
  static const envelope_open_dollar_svg =
      'assets/images/envelope_open_dollar.svg';

  // Icons
  static const icon_button_svg = 'assets/images/icon_button.svg';
  static const icon_close_svg = 'assets/images/icon_close.svg';
  static const icon_arrow_right_svg = 'assets/images/icon_arrow_right.svg';
  static const icon_qrcode_svg = 'assets/images/icon_qrcode.svg';
  static const icon_qrcode_color_svg = 'assets/images/icon_qrcode_color.svg';
  static const icon_leaf_svg = 'assets/images/icon_leaf.svg';

  static const wallet_icon_svg = 'assets/images/wallet_icon.svg';
  static const shop_envelope_open_dollar_svg =
      'assets/images/shop_envelope_open_dollar.svg';
  static const shop_send_money_svg = 'assets/images/shop_send_money.svg';
  static const private_recieve_money_svg =
      'assets/images/private_recieve_money.svg';
  static const private_claim_money_svg =
      'assets/images/private_claim_money.svg';

  // Rectangles
  static const rectangle_blue_svg = 'assets/images/rectangle_blue.svg';
  static const rectangle_green_svg = 'assets/images/rectangle_green.svg';
  static const rectangle_purple_svg = 'assets/images/rectangle_purple.svg';

  static const private_header_svg = 'assets/images/private_header_bg.svg';
  static const shop_header_svg = 'assets/images/shop_header_bg.svg';

  static const wallet_rectangle_green_svg =
      'assets/images/wallet_rectangle_green.svg';
  static const wallet_rectangle_blue_svg =
      'assets/images/wallet_rectangle_blue.svg';

  // Splashscreen
  static const splash_wallet_graphic_svg =
      'assets/images/splash_wallet_graphic.svg';

  // Onboarding
  static const onboarding_icon_wallet_svg =
      'assets/images/onboarding_icon_wallet.svg';
  static const onboarding_icon_shop_svg =
      'assets/images/onboarding_icon_shop.svg';
  static const onboarding_icon_shop_arrows_svg =
      'assets/images/onboarding_icon_shop_arrows.svg';

  static const onboarding_background_graphic_shop_svg =
      'assets/images/onboarding_background_graphic_shop.svg';
  static const onboarding_background_graphic_private_svg =
      'assets/images/onboarding_background_graphic_private.svg';

  static const wallet_shop_svg = 'assets/images/wallet_shop.svg';
  static const wallet_private_svg = 'assets/images/wallet_private.svg';

  static const check_double_svg = 'assets/images/check_double.svg';

  static const qr_code_svg = 'assets/images/qr_code.svg';
  static const cash_register_svg = 'assets/images/cash_register.svg';
}

class GradientStyles {
  static final LinearGradient privateWalletBackgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF7DFF7b),
        Color(0xFF24E8BA),
        Color(0xFF20DBE0),
        Color(0xFF03CF80)
      ],
      stops: [
        0.0,
        0.37,
        1.0,
        1.0
      ]);

  static final LinearGradient shopWalletBackgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF00EAEA),
        Color(0xFF39C1FF),
        Color(0xFF3979FF),
      ],
      stops: [
        0.0,
        0.54,
        1.0,
      ]);

  static final LinearGradient privateWalletAppbarGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF7DFF7b),
        Color(0xFF24E8BA),
        Color(0xFF20DBE0),
        Color(0xFF03CF80)
      ],
      stops: [
        0.0,
        0.37,
        1.0,
        1.0
      ]);

  static final LinearGradient shopWalletAppbarGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF00EAEA),
        Color(0xFF39C1FF),
        Color(0xFF3979FF),
      ],
      stops: [
        0.0,
        0.54,
        1.0,
      ]);
}
