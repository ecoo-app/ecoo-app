import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "Hallo ${name}"
  String greetTo(String name) => "Hallo ${name}";
  /// "Drücke mich"
  String get buttonTabMe => "Drücke mich";
  /// "Bezahlen"
  String get privateWalletPay => "Bezahlen";
  /// "Senden"
  String get privateWalletSend => "Senden";
  /// "Anfordern"
  String get privateWalletRecieve => "Anfordern";
  /// "Gutschrift anfordern"
  String get privateWalletClaim => "Gutschrift anfordern";
  /// "Betrag"
  String get titlePrivateRequest => "Betrag";
  /// "Geld anfordern"
  String get buttonPrivateRequest => "Geld anfordern";
  /// "alle Bewegungen anzeigen"
  String get showAllTransactions => "alle Bewegungen anzeigen";
  /// "Wallet hinzufügen"
  String get addWallet => "Wallet hinzufügen";
  /// "Diese Feld muss ausgefüllt werden."
  String get formErrorRequired => "Diese Feld muss ausgefüllt werden.";
  /// "Wallet typ"
  String get titleWalletCreation => "Wallet typ";
  /// "Polaroid raw denim fingerstache lumbersexual street art kale chips cornhole before they sold out. Wolf VHS shabby chic asymmetrical intelligentsia blue bottle scenester edison bulb 8-bit. Typewriter neutra prism, raclette glossier chartreuse adaptogen food truck jianbing blog craft beer waistcoat paleo. Scenester iceland butcher brunch put a bird on it raw denim taiyaki selfies squid. Seitan bicycle rights man braid fixie truffaut chicharrones cray, vaporware gochujang."
  String get textWalletCreation => "Polaroid raw denim fingerstache lumbersexual street art kale chips cornhole before they sold out. Wolf VHS shabby chic asymmetrical intelligentsia blue bottle scenester edison bulb 8-bit. Typewriter neutra prism, raclette glossier chartreuse adaptogen food truck jianbing blog craft beer waistcoat paleo. Scenester iceland butcher brunch put a bird on it raw denim taiyaki selfies squid. Seitan bicycle rights man braid fixie truffaut chicharrones cray, vaporware gochujang.";
  /// "Verifizieren"
  String get titleClaimVerification => "Verifizieren";
  /// "Jetzt verifizieren"
  String get buttonClaimVerification => "Jetzt verifizieren";
  /// "Später verifizieren"
  String get canselClaimVerification => "Später verifizieren";
  /// "Verifizierung"
  String get titleFormClaimVerification => "Verifizierung";
  /// "Verifizierung"
  String get buttonFormClaimVerification => "Verifizierung";
  /// "Geld senden"
  String get titlePaymentOverview => "Geld senden";
  /// "Bezahlen"
  String get buttonPaymentOverview => "Bezahlen";
  /// "Betrag & Empfänger"
  String get titlePaymentScreen => "Betrag & Empfänger";
  /// "Empfänger"
  String get hintRecieverInput => "Empfänger";
  /// "Uups, der Betrag ist vergessen gegangen."
  String get validationAmountInput => "Uups, der Betrag ist vergessen gegangen.";
  /// "Uups, der Empfänger ist vergessen gegangen."
  String get validationRecieverInput => "Uups, der Empfänger ist vergessen gegangen.";
  /// "QR Rechnung"
  String get titleRequestScreen => "QR Rechnung";
  /// "Wallet ${walletId}"
  String walletRequestScreen(String walletId) => "Wallet ${walletId}";
  /// "CHF ${amount}"
  String amountRequestScreen(String amount) => "CHF ${amount}";
  /// "eCoupon"
  String get titleSplashScreen => "eCoupon";
  /// "Registrieren"
  String get titleRegisterScreen => "Registrieren";
  /// "Um eCoupon zu nutzen muss du dich registrieren, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam  Lorem ipsum dolor sit amet"
  String get descriptionRegisterScreen => "Um eCoupon zu nutzen muss du dich registrieren, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam  Lorem ipsum dolor sit amet";
  /// "Mit Apple fortfahren"
  String get signinwithappleRegisterScreen => "Mit Apple fortfahren";
  /// "Mit Google fortfahren"
  String get signinwithgoogleRegisterScreen => "Mit Google fortfahren";
  /// "Meine Wallets"
  String get titleMenuScreen => "Meine Wallets";
  /// "Erste Schritte"
  String get onboardingMenuScreen => "Erste Schritte";
  /// "FAQ & Hilfe"
  String get faqhelpMenuScreen => "FAQ & Hilfe";
  /// "Datenschutzbestimmungen"
  String get privacyPolicyMenuScreen => "Datenschutzbestimmungen";
  /// "App Version:"
  String get appversionMenuScreen => "App Version:";
  /// "Wallet"
  String get walletMenuScreen => "Wallet";
}

class _I18n_de_CH extends I18n {
  const _I18n_de_CH();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  /// "Hallo ${name}"
  @override
  String greetTo(String name) => "Hallo ${name}";
  /// "Tap me"
  @override
  String get buttonTabMe => "Tap me";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("de", "CH"),
      Locale("en", "US")
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale.languageCode : "";
    if ("de_CH" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_de_CH());
    }
    else if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("de" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_de_CH());
    }
    else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}