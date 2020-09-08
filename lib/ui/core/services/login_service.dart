import 'dart:convert';

import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/services/notification_service.dart';
import 'package:e_coupon/ui/core/services/profile_service.dart';
import 'package:e_coupon/ui/core/services/recovery_service.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:ecoupon_lib/models/client_info.dart';
import 'package:ecoupon_lib/models/session_token.dart';
import 'package:ecoupon_lib/services/session_service.dart';
import 'package:ecoupon_lib/services/wallet_service.dart' as lib;

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class ILoginService {
  Future<LoginResult> login();

  Future<bool> register(SignInProvider provider);

  Future<bool> get isAppleAvailable;

  Future<bool> get isGoogleAvailable;
}

enum LoginResult {
  Migrations,
  Onboarding,
  Home,
}

@Injectable(as: ILoginService)
class LoginService implements ILoginService {
  final IWalletSource _walletSource;
  final ISettingsService _settingsService;
  final IProfileService _profileService;
  final INotificationService _notificationService;
  final IRecoveryService _recoveryService;

  LoginService(this._walletSource, this._settingsService, this._profileService,
      this._notificationService, this._recoveryService);

  lib.WalletService get walletSource => _walletSource.walletService;

  @override
  Future<LoginResult> login() async {
    try {
      var token = await _settingsService.identityToken();
      if (token == null || token == '') {
        // print('No existing Token found');
        return LoginResult.Onboarding;
      } else {
        var newToken = SessionToken.fromJson(jsonDecode(token));
        _walletSource.walletService.session().token = newToken;

        // Test Authentication
        await _profileService.testApi();

        // Test Wallet exists
        final wallets = await _walletSource.walletService.fetchWallets();
        if (wallets != null && wallets.items.isNotEmpty) {
          // Test migrations ongoing
          var areMigrationsInProcess = false;
          (await _recoveryService.migrationInProcess()).fold(
              (l) => null,
              (migrationsInProcess) =>
                  areMigrationsInProcess = migrationsInProcess);

          if (areMigrationsInProcess) {
            return LoginResult.Migrations;
          }
          return LoginResult.Home;
        }

        return LoginResult.Onboarding;
      }
    } on NotAuthenticatedFailure {
      final clientInfo =
          await _walletSource.walletService.session().fetchClientInfo();
      var tokenProvider = await _settingsService
          .readSecureString(Constants.identityTokenProvider);
      var provider = AuthProvider(tokenProvider).convert();
      var result = false;
      switch (provider) {
        case SignInProvider.Apple:
          result = await _signInWithApple(clientInfo);
          break;
        case SignInProvider.Google:
          result = await _signInWithGoogle(clientInfo);
          break;
        default:
          break;
      }
      return result ? LoginResult.Home : LoginResult.Onboarding;
    } catch (e) {
      // print('Unable to sign-in' + e.toString());
      return LoginResult.Onboarding;
    }
  }

  @override
  Future<bool> register(SignInProvider provider) async {
    try {
      final clientInfo =
          await _walletSource.walletService.session().fetchClientInfo();
      switch (provider) {
        case SignInProvider.Apple:
          return await _registerWithApple(clientInfo);
          break;
        case SignInProvider.Google:
          return await _registerWithGoogle(clientInfo);
          break;
        case SignInProvider.Unknown:
          break;
        default:
      }

      return false;
    } on SignInWithAppleException catch (e) {
      print('An SignInWithAppleException occured: ${e}');
      return false;
    } on PlatformException catch (e) {
      print('An PlatformException occured: ${e}');
      return false;
    } catch (e) {
      print('An Exception occured: ${e}');
      return false;
    }
  }

  Future<AuthorizationCredentialAppleID> get appleAuthorization {
    return SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
      ],
    );
  }

  GoogleSignIn get googleSignIn => GoogleSignIn(
        scopes: [
          'email',
        ],
      );

  Future<bool> _registerWithApple(ClientInfo clientInfo) async {
    final AuthorizationCredentialAppleID credential = await appleAuthorization;
    var token = await walletSource
        .session()
        .convertToken(credential.identityToken, clientInfo, AuthProvider.apple);

    await _settingsService.writeSecureString(
        Constants.appleAuthorizationCode, credential.identityToken);

    if (token != null) {
      await _settingsService.saveIdentityToken(jsonEncode(token.toJson()));
      await _settingsService.writeSecureString(
          Constants.identityTokenProvider, AuthProvider.apple.value);
      await _notificationService.registerDevice();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _registerWithGoogle(ClientInfo clientInfo) async {
    GoogleSignIn _googleSignIn = googleSignIn;
    final response = await _googleSignIn.signIn();
    final authentication = await response.authentication;
    var token = await walletSource.session().convertToken(
        authentication.accessToken, clientInfo, AuthProvider.google);
    if (token != null) {
      await _settingsService.saveIdentityToken(jsonEncode(token.toJson()));
      await _settingsService.writeSecureString(
          Constants.identityTokenProvider, AuthProvider.google.value);
      await _notificationService.registerDevice();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _signInWithGoogle(ClientInfo clientInfo) async {
    GoogleSignIn _googleSignIn = googleSignIn;

    if (await _googleSignIn.isSignedIn()) {
      final response = await _googleSignIn.signInSilently(suppressErrors: true);
      final authentication = await response.authentication;
      var token = await walletSource.session().convertToken(
          authentication.accessToken, clientInfo, AuthProvider.google);
      if (token != null) {
        await _settingsService.saveIdentityToken(jsonEncode(token.toJson()));
        await _settingsService.writeSecureString(
            Constants.identityTokenProvider, AuthProvider.google.value);
        return true;
      }
    }
    return false;
  }

  Future<bool> _signInWithApple(ClientInfo clientInfo) async {
    var authCode = await _settingsService
        .readSecureString(Constants.appleAuthorizationCode);

    if (authCode != null) {
      try {
        var token = await walletSource
            .session()
            .convertToken(authCode, clientInfo, AuthProvider.apple);

        if (token != null) {
          await _settingsService.saveIdentityToken(jsonEncode(token.toJson()));
          await _settingsService.writeSecureString(
              Constants.identityTokenProvider, AuthProvider.apple.value);
          await _notificationService.registerDevice();
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print(e.toString());
        return false;
      }
    }

    return _registerWithApple(clientInfo);
  }

  @override
  Future<bool> get isAppleAvailable => SignInWithApple.isAvailable();

  @override
  Future<bool> get isGoogleAvailable => Future.value(true);
}

extension AuthProviderExtension on AuthProvider {
  SignInProvider convert() {
    if (this.value == 'apple-id') {
      return SignInProvider.Apple;
    } else if (this.value == 'google-oauth2') {
      return SignInProvider.Google;
    }
    return SignInProvider.Unknown;
  }
}

enum SignInProvider { Unknown, Apple, Google }
