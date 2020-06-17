import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Intl {
  final Locale locale;
  Map<String, String> _localizedValues;

  Intl(this.locale);

  static Intl of(BuildContext context) {
    return Localizations.of<Intl>(context, Intl);
  }

  Future load() async {
    String jsonStringValues;
    if (locale.countryCode.isNotEmpty) {
      jsonStringValues = await rootBundle.loadString(
          'lib/ui/localization/lang/${locale.languageCode}_${locale.countryCode}.json');
    } else {
      jsonStringValues = await rootBundle
          .loadString('lib/ui/localization/lang/${locale.languageCode}.json');
    }

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static getSupportedLocales() {
    return [
      const Locale('de', 'CH'),
      const Locale('en', '') // English, no country code
    ];
  }

  static const LocalizationsDelegate<Intl> delegate = _IntlDelgegate();
}

///
///
/// localization delegate
///
class _IntlDelgegate extends LocalizationsDelegate<Intl> {
  const _IntlDelgegate();

  @override
  bool isSupported(Locale locale) {
    // TODO somehow use supported locales !!

    // var supportedLocales = Intl.getSupportedLocales();
    // print("${locale.languageCode}_${locale.countryCode}");
    // print(supportedLocales);
    // print(supportedLocales.contains(locale.languageCode));

    // return (supportedLocales.contains(locale.languageCode) ||
    //     supportedLocales
    //         .contains("${locale.languageCode}_${locale.countryCode}"));

    return ['en', 'de_CH'].contains(locale.languageCode) ||
        ['en', 'de_CH']
            .contains("${locale.languageCode}_${locale.countryCode}");
  }

  @override
  Future<Intl> load(Locale locale) async {
    Intl intl = new Intl(locale);
    await intl.load();
    return intl;
  }

  @override
  bool shouldReload(_IntlDelgegate old) => false;
}

String getTranslated(BuildContext context, String key) {
  return Intl.of(context).getTranslatedValue(key);
}
