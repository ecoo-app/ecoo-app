import 'package:e_coupon/data/e_coupon_library/lib_wallet_source.dart';
import 'package:ecoupon_lib/models/session_token.dart';
import 'package:ecoupon_lib/services/session_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MockLoginService {
  final IWalletSource _walletSource;

  MockLoginService(this._walletSource);

  GoogleSignIn get googleSignIn => GoogleSignIn(
        scopes: [
          'email',
        ],
      );

  Future<SessionToken> registerWithGoogle() async {
    var service = _walletSource.walletService;
    final clientInfo = await service.session().fetchClientInfo();
    GoogleSignIn _googleSignIn = googleSignIn;

    final response = await _googleSignIn.signIn();
    final authentication = await response.authentication;
    return _walletSource.walletService.session().convertToken(
        authentication.accessToken, clientInfo, AuthProvider.google);
  }

  Future<void> testLogin(bool _useSignInWithApple) async {
    var service = _walletSource.walletService;

    if (service.session().token != null) {
      return;
    }
    try {
      final clientInfo = await service.session().fetchClientInfo();
      // if (!_useSignInWithApple) {
      final googleSignIn = GoogleSignIn(scopes: ['email']);
      final response = await googleSignIn.signIn();
      final authentication = await response.authentication;
      await service.session().convertToken(
          authentication.accessToken, clientInfo, AuthProvider.google);
      // var account = await googleSignIn.signInSilently();
      // final GoogleSignInAuthentication authentication =
      //     await account.authentication;
      // await service.session().convertToken(
      //     authentication.accessToken, clientInfo, AuthProvider.google);
    } catch (e) {
      print('error ${e.toString()}');
    }

    // } else {
    //   final credential = await SignInWithApple.getAppleIDCredential(
    //       scopes: [AppleIDAuthorizationScopes.email]);
    //   await service.session().convertToken(
    //       credential.identityToken, clientInfo, AuthProvider.apple);
    // }
  }
}
