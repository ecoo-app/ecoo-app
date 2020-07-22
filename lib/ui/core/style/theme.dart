import 'package:flutter/material.dart';

const FontWeight fontWeightMedium = FontWeight.w500;
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

class ColorStyles {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF373737);
  static const Color brown_gray = Color(0xFF979797);
  static const Color bg_gray = Color(0xFF575757);
  static const Color bg_light_gray = Color(0xFFF7F7F7);

  static const Color blue = Color(0xFF3979FF);
  static const Color green = Color(0xFF3979FF);
}

class LayoutStyles {
  static const double iconSize = 23;
}

class Assets {
  static const close_svg = 'assets/images/close.svg';
  static const tezos_svg = 'assets/images/tezos.svg';
  static const apple_icon_svg = 'assets/images/apple_icon.svg';
  static const google_icon_svg = 'assets/images/google_icon.svg';

  static const wallet_svg = 'assets/images/wallet_icon.svg';
  static const splash_recangle_left_svg =
      'assets/images/splash_rectangle_left.svg';
  static const splash_recangle_top_svg =
      'assets/images/splash_rectangle_top.svg';
  static const splash_recangle_right_svg =
      'assets/images/splash_rectangle_right.svg';

  static const wallet_shop_svg = 'assets/images/wallet_shop.svg';
  static const wallet_private_svg = 'assets/images/wallet_private.svg';
}
