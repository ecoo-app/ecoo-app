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
  /// "Guthaben aufladen"
  String get privateWalletClaim => "Guthaben aufladen";
  /// "Einlösen"
  String get walletRedeem => "Einlösen";
  /// "Kassieren"
  String get walletCashier => "Kassieren";
  /// "Verlauf"
  String get walletTimline => "Verlauf";
  /// "Betrag"
  String get titlePrivateRequest => "Betrag";
  /// "Geld anfordern"
  String get buttonPrivateRequest => "Geld anfordern";
  /// "Rechnung erstellen"
  String get buttonShopRequest => "Rechnung erstellen";
  /// "alle Bewegungen anzeigen"
  String get showAllTransactions => "alle Bewegungen anzeigen";
  /// "Wallet hinzufügen"
  String get addWallet => "Wallet hinzufügen";
  /// "Dieses Feld muss ausgefüllt werden."
  String get formErrorRequired => "Dieses Feld muss ausgefüllt werden.";
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
  /// "Personalien"
  String get verificationPrivateFormTitle => "Personalien";
  /// "UID"
  String get verificationShopFormTitle => "UID";
  /// "Firma"
  String get verificationShopFormCompanyTitle => "Firma";
  /// "Unternehmens-Identifikationsnummer (UID) \n\nIhre UID finden Sie unter: "
  String get verificationShopFormUidDescription => "Unternehmens-Identifikationsnummer (UID) \n\nIhre UID finden Sie unter: ";
  /// "https://www.uid.admin.ch/"
  String get verificationShopFormUidLink => "https://www.uid.admin.ch/";
  /// "Ich habe keine UID"
  String get verificationShopFormUidNoUid => "Ich habe keine UID";
  /// "Ich bestätige alles wahrheitsgetreu ausgefüllt zu haben."
  String get verificationFilledTruthfully => "Ich bestätige alles wahrheitsgetreu ausgefüllt zu haben.";
  /// "Anfrage gesendet."
  String get verificationSend => "Anfrage gesendet.";
  /// "PIN eingeben"
  String get pinVerificationTitle => "PIN eingeben";
  /// "PIN erhalten von der Gemeinde"
  String get pinRecieved => "PIN erhalten von der Gemeinde";
  /// "Geben Sie den PIN ein, den sie von Ihrer Gemeinde erhalten haben."
  String get enterPin => "Geben Sie den PIN ein, den sie von Ihrer Gemeinde erhalten haben.";
  /// "PIN"
  String get pinInputLabel => "PIN";
  /// "Verifizierung erfolgreich"
  String get successTextVerification => "Verifizierung erfolgreich";
  /// "Überprüfen"
  String get verifyPinButton => "Überprüfen";
  /// "Umsatz einlösen"
  String get titleRedeem => "Umsatz einlösen";
  /// "Umsatz einlösen"
  String get buttonRedeem => "Umsatz einlösen";
  /// "Der Betrag wird übermittelt an:"
  String get redeemTransferTo => "Der Betrag wird übermittelt an:";
  /// "Nach der Überprüfung wird Ihnen das Geld auf das angegebende Konto überwiesen."
  String get redeemInfo => "Nach der Überprüfung wird Ihnen das Geld auf das angegebende Konto überwiesen.";
  /// "Name der Bank"
  String get redeemFieldNameBank => "Name der Bank";
  /// "IBAN Nummer"
  String get redeemFieldIBAN => "IBAN Nummer";
  /// "Kontoinhaber"
  String get redeemFieldAccountOwner => "Kontoinhaber";
  /// "Geld senden"
  String get titlePaymentOverview => "Geld senden";
  /// "Bezahlen"
  String get buttonPaymentOverview => "Bezahlen";
  /// "Betrag & Empfänger"
  String get titlePaymentScreen => "Betrag & Empfänger";
  /// "Senden an:"
  String get labelRecieverInput => "Senden an:";
  /// "Wallet ID"
  String get hintRecieverInput => "Wallet ID";
  /// "Uups, ist etwas vergessen gegangen."
  String get inputValidation => "Uups, ist etwas vergessen gegangen.";
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
  /// "ecoo"
  String get titleSplashScreen => "ecoo";
  /// "Registrieren"
  String get titleRegisterScreen => "Registrieren";
  /// "Um das ecoo App zu benutzten, müssen Sie sich zuerst mit ihrer Apple ID oder Google ID registrieren. Dies dient zur Anmeldung und weder Google noch Apple hat Zugriff auf ihre Daten im App selbst."
  String get descriptionRegisterScreen => "Um das ecoo App zu benutzten, müssen Sie sich zuerst mit ihrer Apple ID oder Google ID registrieren. Dies dient zur Anmeldung und weder Google noch Apple hat Zugriff auf ihre Daten im App selbst.";
  /// "Mit Apple fortfahren"
  String get signinwithappleRegisterScreen => "Mit Apple fortfahren";
  /// "Mit Google fortfahren"
  String get signinwithgoogleRegisterScreen => "Mit Google fortfahren";
  /// "Einführung wiederholen"
  String get onboardingRegisterScreen => "Einführung wiederholen";
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
  /// "QR Code scannen"
  String get titleScanScreen => "QR Code scannen";
  /// "Manuell eingeben"
  String get cancelScan => "Manuell eingeben";
  /// "Bezahlung erfolgreich"
  String get paymentSuccessful => "Bezahlung erfolgreich";
  /// "Keine Internetverbindung"
  String get noServiceErrorTitle => "Keine Internetverbindung";
  /// "Es besteht keine Verbindung zum Internet."
  String get noServiceErrorText => "Es besteht keine Verbindung zum Internet.";
  /// "Fehler"
  String get generalErrorTitle => "Fehler";
  /// "Es ist ein unbekannter Fehler aufgetreten."
  String get generalErrorText => "Es ist ein unbekannter Fehler aufgetreten.";
  /// "Zahlung fehlgeschlagen"
  String get paymentFailed => "Zahlung fehlgeschlagen";
  /// "Überprüfe deine Internetverbindung und probiere es noch einmal oder lasse dein gegenüber den QR-Code scannen."
  String get paymentFailedInfo => "Überprüfe deine Internetverbindung und probiere es noch einmal oder lasse dein gegenüber den QR-Code scannen.";
  /// "Ich zahle den offenen Betrag an:"
  String get iPay => "Ich zahle den offenen Betrag an:";
  /// "ecoo"
  String get page1TitleOnboardingScreen => "ecoo";
  /// "Registrierung und verifizierung"
  String get page1HeadlineOnboardingScreen => "Registrierung und verifizierung";
  /// "Um ecoo zu nutzen müssen Sie sich zuerst mit ihrer Apple ID oder Google ID registrieren. \n\nIm zweiten Schritt verifiziern Sie sich mit ein paar wenigen Angaben bei ihrer Gemeinde, danach erhalten Sie automatisch das Guthaben auf ihr Wallet."
  String get page1DescriptionOnboardingScreen => "Um ecoo zu nutzen müssen Sie sich zuerst mit ihrer Apple ID oder Google ID registrieren. \n\nIm zweiten Schritt verifiziern Sie sich mit ein paar wenigen Angaben bei ihrer Gemeinde, danach erhalten Sie automatisch das Guthaben auf ihr Wallet.";
  /// "Privat wallet"
  String get page2TitleOnboardingScreen => "Privat wallet";
  /// "Zahlen, Senden & Geld anfordern"
  String get page2HeadlineOnboardingScreen => "Zahlen, Senden & Geld anfordern";
  /// "Als privat Person haben sie die Möglichkeit in den verifizierten Geschäften mit ecoo zu bezahlen.\n\nSie können andern ecoo Benutzer Guthaben senden oder Guthaben von anderen Benutzer anfordern.\n\nEs besteht die Möglichkeit alle erhalten Gutscheine ihrer Familie in einem Wallet zu speichern."
  String get page2DescriptionOnboardingScreen => "Als privat Person haben sie die Möglichkeit in den verifizierten Geschäften mit ecoo zu bezahlen.\n\nSie können andern ecoo Benutzer Guthaben senden oder Guthaben von anderen Benutzer anfordern.\n\nEs besteht die Möglichkeit alle erhalten Gutscheine ihrer Familie in einem Wallet zu speichern.";
  /// "Shop wallet"
  String get page3TitleOnboardingScreen => "Shop wallet";
  /// "Einkassieren & senden"
  String get page3HeadlineOnboardingScreen => "Einkassieren & senden";
  /// "Mit einem Shop wallet sind Sie in wenigen Schritten bereit Einkäufe in ihrem Geschäft über die ecoo App zu kassieren.\n\nSie haben die Möglichkeit Beträge anderen ecoo Benutzern zu senden."
  String get page3DescriptionOnboardingScreen => "Mit einem Shop wallet sind Sie in wenigen Schritten bereit Einkäufe in ihrem Geschäft über die ecoo App zu kassieren.\n\nSie haben die Möglichkeit Beträge anderen ecoo Benutzern zu senden.";
  /// "Shop wallet"
  String get page4TitleOnboardingScreen => "Shop wallet";
  /// "Umsatz einlösen"
  String get page4HeadlineOnboardingScreen => "Umsatz einlösen";
  /// "Nach der Verifizierung bei ihrer Gemeinde können Sie mit wenigen Klicks den erzielten Umsatz bei der Gemeinde einlösen.\n\nNach der Überpüfung wird Ihnen der Betrag auf dem Angegeben Konto gutgeschrieben."
  String get page4DescriptionOnboardingScreen => "Nach der Verifizierung bei ihrer Gemeinde können Sie mit wenigen Klicks den erzielten Umsatz bei der Gemeinde einlösen.\n\nNach der Überpüfung wird Ihnen der Betrag auf dem Angegeben Konto gutgeschrieben.";
  /// "Einführung überspringen"
  String get buttonTextSkipOnboardingScreen => "Einführung überspringen";
  /// "Jetzt registrieren"
  String get buttonTextNextOnboardingScreen => "Jetzt registrieren";
  /// "Wallet Typ"
  String get titleRegisterWalletTypeScreen => "Wallet Typ";
  /// "Bitte wählen Sie hier aus welcher Typ Wallet Sie brauchen. Alle Privatpersonen haben Anrecht auf ein Private Wallet. Als Gewerbebesitzer machen Sie für ihr Geschäft zusätzlich ein Firmen Wallet aus."
  String get descriptionRegisterWalletTypeScreen => "Bitte wählen Sie hier aus welcher Typ Wallet Sie brauchen. Alle Privatpersonen haben Anrecht auf ein Private Wallet. Als Gewerbebesitzer machen Sie für ihr Geschäft zusätzlich ein Firmen Wallet aus.";
  /// "Privat"
  String get privateRegisterWalletTypeScreen => "Privat";
  /// "Firma"
  String get shopRegisterWalletTypeScreen => "Firma";
  /// "Verifizieren"
  String get titleRegisterVerifyScreen => "Verifizieren";
  /// "Um Guthaben auf das Wallet zu laden, müssen Sie sich verifizieren.\n\nNach automatischer Überprüfung Ihrer Daten, wird Ihnen ein Pin per SMS geschickt, mit dem Sie diesen Prozess abschliessen können."
  String get descriptionRegisterVerifyScreen => "Um Guthaben auf das Wallet zu laden, müssen Sie sich verifizieren.\n\nNach automatischer Überprüfung Ihrer Daten, wird Ihnen ein Pin per SMS geschickt, mit dem Sie diesen Prozess abschliessen können.";
  /// "Jetzt verifizieren"
  String get verifyButtonRegisterVerifyScreen => "Jetzt verifizieren";
  /// "Später verifizieren"
  String get verifyLaterButtonRegisterVerifyScreen => "Später verifizieren";
  /// "Vorname"
  String get verifyFormFieldFirstName => "Vorname";
  /// "Nachname"
  String get verifyFormFieldLastName => "Nachname";
  /// "Telefonnummer"
  String get verifyFormFieldPhoneNumber => "Telefonnummer";
  /// "Geburtsdatum"
  String get verifyFormFieldBirthday => "Geburtsdatum";
  /// "Strasse & Hausnummer"
  String get verifyFormFieldAddress => "Strasse & Hausnummer";
  /// "PLZ"
  String get verifyFormFieldPostcode => "PLZ";
  /// "Ort"
  String get verifyFormFieldCity => "Ort";
  /// "Firmenname"
  String get verifyFormFieldCompany => "Firmenname";
  /// "Transaktion erfolgreich"
  String get transactionSuccessful => "Transaktion erfolgreich";
  /// "Paper Wallet scannen"
  String get scanPaperWalletButton => "Paper Wallet scannen";
  /// "Deine Angaben konnten nicht verifiziert werden. Bitte trete mit der Gemeinde in Kontakt."
  String get verifyFormErrorVerification => "Deine Angaben konnten nicht verifiziert werden. Bitte trete mit der Gemeinde in Kontakt.";
  /// "Das Wallet konnte nicht erstellt werden. Versuche es noch einmal."
  String get walletSelectionScreenError => "Das Wallet konnte nicht erstellt werden. Versuche es noch einmal.";
  /// "https://payecoo.ch/datenschutz.html"
  String get dataPolicyUrl => "https://payecoo.ch/datenschutz.html";
  /// "https://tezos.foundation/"
  String get tezosFoundationUrl => "https://tezos.foundation/";
  /// "Ich bestätige, dass meine Angaben vollständig und wahrheitsgetreu ausgefüllt sind."
  String get truthfullyEnteredFormCheck => "Ich bestätige, dass meine Angaben vollständig und wahrheitsgetreu ausgefüllt sind.";
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