import 'dart:ui';

class Constants {
  static const firstInstallCompleteSettingsKey = 'firstInstallComplete';
  static const lastWalletIDSettingsKey = 'lasWalletID';
  static const notFirstInstallKey = 'notFirstInstall';

  static const userProfileUuid = 'userProfileUuid';

  static const identityTokenKey = 'refreshTokenKey';
  static const identityTokenProvider = 'identityTokenProvider';
  static const appleAuthorizationCode = 'appleAuthorizationCode';

  static const qrDataDestinationId = 'id';
  static const qrDataAmount = 'amount';
  static const qrDataNonce = 'nonce';
  static const qrDataPublicKey = 'pk';

  static const localStorageKey = 'ecooStorage';
  static const localMigrationCheck = 'migrationChecks';
  // static const defaultLocale = 'de-CH';

  static Locale defaultLocale = Locale('de', 'CH');
}
