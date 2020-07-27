import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

const FontWeight fontWeightMedium = FontWeight.w500;
const FontWeight fontWeightBold = FontWeight.w800;
const FontWeight fontWeightRegular = FontWeight.w400;

const String fontFamiliyPanam = 'NewPanam';

ThemeData generalTheme = ThemeData(
  accentColor: Colors.amber,
  primaryColor: Colors.cyan,
  scaffoldBackgroundColor: ColorStyles.white,
  backgroundColor: ColorStyles.white,
  textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 75.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam,
          color: ColorStyles.black),
      headline2: TextStyle(
          fontSize: 50.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam,
          color: ColorStyles.black),
      headline3: TextStyle(
          fontSize: 25.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam,
          color: ColorStyles.black),
      headline4: TextStyle(
          fontSize: 25.0, fontWeight: fontWeightMedium, fontFamily: 'Roboto'),
      button: TextStyle(
          fontSize: 25.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam),
      bodyText1: TextStyle(
          fontSize: 15.0,
          fontWeight: fontWeightMedium,
          fontFamily: fontFamiliyPanam),
      bodyText2: TextStyle(
          fontSize: 15.0, fontWeight: fontWeightRegular, fontFamily: 'Roboto'),
      caption: TextStyle(
          fontSize: 10.0, fontWeight: fontWeightRegular, fontFamily: 'Roboto')),
);

class TextStyles {
  static const body_text_black = TextStyle(
      fontSize: 15.0,
      fontWeight: fontWeightRegular,
      fontFamily: 'Roboto',
      color: Colors.black);

  static const body_text_white = TextStyle(
      fontSize: 15.0,
      fontWeight: fontWeightRegular,
      fontFamily: 'Roboto',
      color: Colors.white);

  static const headline3_text_white = TextStyle(
      fontSize: 25.0,
      fontWeight: fontWeightMedium,
      fontFamily: fontFamiliyPanam,
      color: ColorStyles.white);
}

class ColorStyles {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF373737);
  static const Color brown_gray = Color(0xFF979797);
  static const Color bg_gray = Color(0xFF575757);
  static const Color bg_light_gray = Color(0xFFF7F7F7);
  static const Color bg_transparent = Color(0x40000000);

  static const Color blue = Color(0xFF3979FF);
  static const Color green = Color(0xFF3979FF);

  static LinearGradient app_gradient = Gradients.blush;
  static LinearGradient private_gradient = Gradients.coldLinear;
  static LinearGradient shop_graident = Gradients.rainbowBlue;
}

class LayoutStyles {
  static const double iconSize = 23;

  static const double spacing_xs = 4;
  static const double spacing_s = 8;
  static const double spacing_m = 25.0;
}

class Assets {
  static const close_svg = 'assets/images/close.svg';
  static const tezos_svg = 'assets/images/tezos.svg';
  static const apple_icon_svg = 'assets/images/apple_icon.svg';
  static const google_icon_svg = 'assets/images/google_icon.svg';

  static const icon_button_svg = 'assets/images/icon_button.svg';

  static const wallet_svg = 'assets/images/wallet_icon.svg';

  // Splashscreen
  static const splash_wallet_graphic_svg =
      'assets/images/splash_wallet_graphic.svg';

  // Onboarding
  static const onboarding_icon_wallet_svg =
      'assets/images/onboarding_wallet_icon.svg';
  static const onboarding_background_graphic_svg =
      'assets/images/onboarding_background_graphic.svg';
  static const onboarding_icon_background_svg =
      'assets/images/onboarding_icon_background.svg';

  static const wallet_shop_svg = 'assets/images/wallet_shop.svg';
  static const wallet_private_svg = 'assets/images/wallet_private.svg';

  static const check_double_svg = 'assets/images/check_double.svg';

  static const qr_code_svg = 'assets/images/qr_code.svg';
}

class GradientStyles extends Gradients {
  static final AlignmentGeometry _beginAlignment = Alignment.topLeft;
  static final AlignmentGeometry _endAlignment = Alignment.bottomRight;

  // static LinearGradient defaultGradient = Gradients.buildGradient(
  //     _beginAlignment,
  //     _endAlignment,
  //     const [Color(0xffFFF0D1), Color(0xffFFB8C6)]);

  static LinearGradient actionGradient = Gradients.buildGradient(
      _beginAlignment,
      _endAlignment,
      const [Color(0xff7dff7b), Color(0xff03cf80)]);

  static LinearGradient privateGradient = Gradients.buildGradient(
      _beginAlignment,
      _endAlignment,
      const [Color(0xff7dff7b), Color(0xff03cf80)]);

  static LinearGradient shopGradient = Gradients.buildGradient(_beginAlignment,
      _endAlignment, const [Color(0xff7dff7b), Color(0xff03cf80)]);

  static LinearGradient errorGradient = Gradients.buildGradient(
      Alignment.topCenter,
      Alignment.bottomCenter,
      const [Color(0xfff1327f), Color(0xff9774ff)]);
}
