import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/screens/redeem/redeem_screen.dart';
import 'package:e_coupon/ui/screens/start/migration_check_screen.dart';
import 'package:e_coupon/ui/screens/start/no_service_screen.dart';
import 'package:e_coupon/ui/screens/verification/info_screen.dart';
import 'package:e_coupon/ui/screens/verification/pin_verification_screen.dart';
import 'package:e_coupon/ui/screens/payment/payment_screen.dart';
import 'package:e_coupon/ui/screens/payment/qr_scanner_screen.dart';
import 'package:e_coupon/ui/screens/payment/qrbill_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_screen.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:e_coupon/ui/screens/register/register_screen.dart';
import 'package:e_coupon/ui/screens/register/register_verifiy_screen.dart';
import 'package:e_coupon/ui/screens/register/wallet_selection_screen.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen.dart';
import 'package:e_coupon/ui/screens/start/splash_screen.dart';
import 'package:e_coupon/ui/screens/wallet/qr_overlay.dart';
import 'package:e_coupon/ui/screens/verification/verification_screen.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const SplashRoute = '/splash';
const OnboardingRoute = '/onboarding';
const RegisterRoute = '/register';
const WalletSelectionRoute = '/register/wallettype';
const RegisterVerifyRoute = '/register/verify';
const VerifyPinRoute = '/verify/pin';
const VerificationRoute = '/verify';
const WalletDetailRoute = '/wallet';
const TransactionOverviewRoute = 'transactionOverview';
const PaymentRoute = 'payment';
const SuccessRoute = 'success';
const InfoRoute = '/info';
const RequestPaymentRoute = 'requestPayment';
const RequestQRBillRoute = 'requestQRBill';
const QRScanRoute = '/scan';
const WalletQROverlayRoute = '/wallet/qrOverlay';
const RedeemRoute = '/redeem';
const MigrationRoute = '/migration';
const NoServiceRoute = '/noservice';

abstract class IRouter {
  GlobalKey<NavigatorState> get navigatorKey;

  void pop();

  Future<T> pushNamed<T>(String route, {dynamic arguments});

  Future<void> pushAndRemoveUntil(String route, String until,
      {dynamic arguments});

  void popUntil(bool Function(Route<dynamic>) predicate);
}

@Singleton(as: IRouter)
class Router implements IRouter {
  final GlobalKey<NavigatorState> _globalNavKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _globalNavKey;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case QRScanRoute:
        var showButton = settings.arguments as bool;
        return showButton == null
            ? MaterialPageRoute(
                builder: (_) => QRScannerScreen(), fullscreenDialog: true)
            : MaterialPageRoute(
                builder: (_) => QRScannerScreen(showButton: showButton),
                fullscreenDialog: true);
      case SplashRoute:
        return _createRoute(settings, getIt<SplashScreen>(), false);
      case OnboardingRoute:
        return _createRoute(settings, getIt<OnboardingScreen>(), true);
      case RegisterRoute:
        return _createRoute(settings, getIt<RegisterScreen>(), false);
      case WalletSelectionRoute:
        return _createRoute(settings, getIt<WalletSelectionScreen>(), false);
      case RegisterVerifyRoute:
        return _createRoute(settings, getIt<RegisterVerifyScreen>(), false);
      case WalletDetailRoute:
        return _createRoute(settings, getIt<WalletScreen>(), false);
      case VerificationRoute:
        return _createRoute(settings, getIt<VerificationScreen>(), true);
      case PaymentRoute:
        return _createRoute(settings, getIt<PaymentScreen>(), false);
      case SuccessRoute:
        final SuccessScreenArguments args =
            settings.arguments as SuccessScreenArguments;
        return MaterialPageRoute(
            builder: (_) => SuccessScreen(args), fullscreenDialog: true);
      case RequestPaymentRoute:
        return _createRoute(settings, getIt<RequestScreen>(), true);
      case RequestQRBillRoute:
        return _createRoute(settings, getIt<RequestQRBillScreen>(), false);
      case WalletQROverlayRoute:
        return _createRoute(settings, getIt<WalletQROverlay>(), true);
      case VerifyPinRoute:
        return _createRoute(settings, getIt<PinVerificationScreen>(), false);
      case RedeemRoute:
        return _createRoute(settings, getIt<RedeemScreen>(), false);
      case MigrationRoute:
        return _createRoute(settings, getIt<MigrationCheckScreen>(), false);
      case InfoRoute:
        return _createRoute(settings, getIt<VerificationInfoScreen>(), true);
      case NoServiceRoute:
        return _createRoute(settings, getIt<NoServiceInfoScreen>(), true);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }

  static MaterialPageRoute _createRoute(
      RouteSettings settings, Widget builder, bool modalDialog) {
    return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => builder,
        fullscreenDialog: modalDialog);
  }

  @override
  void pop() {
    return navigatorKey.currentState.pop();
  }

  @override
  Future<T> pushNamed<T>(String route, {arguments}) {
    return navigatorKey.currentState.pushNamed(route, arguments: arguments);
  }

  @override
  Future<void> pushAndRemoveUntil(String route, String until, {arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
        route, (route) => route.settings.name == until,
        arguments: arguments);
  }

  @override
  void popUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState.popUntil(predicate);
  }
}
