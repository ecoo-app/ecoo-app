import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/screens/redeem/redeem_screen.dart';
import 'package:e_coupon/ui/screens/verification/pin_verification_screen.dart';
import 'package:e_coupon/ui/screens/payment/error_screen.dart';
import 'package:e_coupon/ui/screens/payment/payment_screen.dart';
import 'package:e_coupon/ui/screens/payment/qr_scanner_screen.dart';
import 'package:e_coupon/ui/screens/payment/qrbill_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_screen.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:e_coupon/ui/screens/register/register_screen.dart';
import 'package:e_coupon/ui/screens/register/register_verifiy_screen.dart';
import 'package:e_coupon/ui/screens/register/register_wallet_type_screen.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen.dart';
import 'package:e_coupon/ui/screens/start/splash_screen.dart';
import 'package:e_coupon/ui/screens/wallet/qr_overlay.dart';
import 'package:e_coupon/ui/screens/verification/verification_screen.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_screen.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

// unfortunately routesetting does not allow enums
const HomeRoute = '/';
const SplashRoute = '/splash';
const OnboardingRoute = '/onboarding';
const RegisterRoute = '/register';
const RegisterWalletTypeRoute = '/register/wallettype';
const RegisterVerifyRoute = '/register/verify';
const VerifyPinRoute = '/verify/pin';
const VerificationRoute = '/verify';
const WalletDetailRoute = '/wallet';
const WalletsOverviewRoute = 'walletsOverview';
const TransactionOverviewRoute = 'transactionOverview';
const PaymentRoute = 'payment';
const SuccessRoute = 'success';
const ErrorRoute = 'paymentError';
const RequestPaymentRoute = 'requestPayment';
const RequestQRBillRoute = 'requestQRBill';
const QRScanRoute = '/scan';
const WalletQROverlayRoute = '/wallet/qrOverlay';
const RedeemRoute = '/redeem';

abstract class IRouter {
  GlobalKey<NavigatorState> get navigatorKey;

  void pop();

  Future<T> pushNamed<T>(String route, {dynamic arguments});

  Future<void> pushAndRemoveUntil(String route, String until,
      {dynamic arguments});
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
            ? MaterialPageRoute(builder: (_) => QRScannerScreen())
            : MaterialPageRoute(
                builder: (_) => QRScannerScreen(showButton: showButton));
      case SplashRoute:
        return _createRoute(settings, getIt<SplashScreen>(), false);
      case OnboardingRoute:
        return _createRoute(settings, getIt<OnboardingScreen>(), true);
      case RegisterRoute:
        return _createRoute(settings, getIt<RegisterScreen>(), false);
      case RegisterWalletTypeRoute:
        return _createRoute(settings, getIt<RegisterWalletTypeScreen>(), false);
      case RegisterVerifyRoute:
        return _createRoute(settings, getIt<RegisterVerifyScreen>(), false);
      case HomeRoute:
      case WalletDetailRoute:
        return _createRoute(settings, getIt<WalletScreen>(), false);
      case WalletsOverviewRoute:
        return MaterialPageRoute(builder: (_) => WalletsOverviewScreen());
      case VerificationRoute:
        return _createRoute(settings, getIt<VerificationScreen>(), true);
      case PaymentRoute:
        return _createRoute(settings, PaymentScreen(), false);
      case SuccessRoute:
        final SuccessScreenArguments args =
            settings.arguments as SuccessScreenArguments;
        return MaterialPageRoute(
            builder: (_) => SuccessScreen(args), fullscreenDialog: true);
      case ErrorRoute:
        return _createRoute(settings, getIt<ErrorScreen>(), false);
      case RequestPaymentRoute:
        return _createRoute(settings, getIt<RequestScreen>(), false);
      case RequestQRBillRoute:
        return _createRoute(settings, getIt<RequestQRBillScreen>(), false);
      case WalletQROverlayRoute:
        return _createRoute(settings, getIt<WalletQROverlay>(), true);
      case VerifyPinRoute:
        return _createRoute(settings, getIt<PinVerificationScreen>(), false);
      case RedeemRoute:
        return _createRoute(settings, getIt<RedeemScreen>(), false);
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
}
