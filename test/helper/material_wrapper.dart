import 'package:e_coupon/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MaterialWrapper {
  static Widget wrap(Widget widget) {
    final i18n = I18n.delegate;

    return MaterialApp(
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(fallback: Locale("de", "CH")),
      home: Scaffold(
        body: widget,
      ),
    );
  }
}
