import 'package:flutter/material.dart';

var fontWeightMedium = FontWeight.w500;
var fontWeightRegular = FontWeight.w400;

ThemeData generalTheme = ThemeData(
  accentColor: Colors.amber,
  primaryColor: Colors.cyan,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 75, fontWeight: fontWeightMedium, fontFamily: 'NewPanam'),
      headline2: TextStyle(
          fontSize: 50.0, fontWeight: fontWeightMedium, fontFamily: 'NewPanam'),
      headline3: TextStyle(
          fontSize: 25.0, fontWeight: fontWeightMedium, fontFamily: 'NewPanam'),
      headline4: TextStyle(
          fontSize: 25.0, fontWeight: fontWeightMedium, fontFamily: 'Roboto'),
      button: TextStyle(
          fontSize: 25.0, fontWeight: fontWeightMedium, fontFamily: 'NewPanam'),
      bodyText1: TextStyle(
          fontSize: 15.0, fontWeight: fontWeightMedium, fontFamily: 'NewPanam'),
      bodyText2: TextStyle(
          fontSize: 15.0, fontWeight: fontWeightRegular, fontFamily: 'Roboto'),
      caption: TextStyle(
          fontSize: 10.0, fontWeight: fontWeightRegular, fontFamily: 'Roboto')),
);
