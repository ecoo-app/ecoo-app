import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/screens/creation_verification/wallet_creation_screen.dart';
import 'package:e_coupon/ui/screens/payment/error_screen.dart';
import 'package:e_coupon/ui/screens/payment/payment_screen.dart';
import 'package:e_coupon/ui/screens/payment/qr_scanner_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_qrbill_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_screen.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:e_coupon/ui/screens/register/register_screen.dart';
import 'package:e_coupon/ui/screens/register/register_verifiy_screen.dart';
import 'package:e_coupon/ui/screens/register/register_wallet_type_screen.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen.dart';
import 'package:e_coupon/ui/screens/start/splash_screen.dart';
import 'package:e_coupon/ui/screens/transaction_overview/transaction_overview_screen.dart';
import 'package:e_coupon/ui/screens/creation_verification/verification_screen.dart';
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
const WalletCreationRoute = 'walletCreation';
const WalletDetailRoute = 'walletDetail';
const WalletsOverviewRoute = 'walletsOverview';
const TransactionOverviewRoute = 'transactionOverview';
const ClaimVerificationRoute = 'claimVerification';
const PaymentRoute = 'payment';
const SuccessRoute = 'success';
const ErrorRoute = 'paymentError';
const RequestPaymentRoute = 'requestPayment';
const RequestQRBillRoute = 'requestQRBill';
const TestRoute = '/test';

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
      case TestRoute:
        return MaterialPageRoute(builder: (_) => QRScannerScreen());
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
      case WalletCreationRoute:
        return MaterialPageRoute(builder: (_) => WalletCreationScreen());
      case HomeRoute:
      case WalletDetailRoute:
        var walletId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => WalletScreen(walletId: walletId));
      case WalletsOverviewRoute:
        // var post = settings.arguments as Post;
        // return MaterialPageRoute(builder: (_) => WalletScreen(post: post));
        return MaterialPageRoute(builder: (_) => WalletsOverviewScreen());
      case TransactionOverviewRoute:
        return MaterialPageRoute(builder: (_) => TransactionOverviewScreen());
      case ClaimVerificationRoute:
        return MaterialPageRoute(builder: (_) => VerificationScreen());
      case PaymentRoute:
        return _createRoute(settings, PaymentScreen(), false);
      case SuccessRoute:
        final SuccessScreenArguments args =
            settings.arguments as SuccessScreenArguments;
        return MaterialPageRoute(builder: (_) => SuccessScreen(args));
      case ErrorRoute:
        return _createRoute(settings, getIt<ErrorScreen>(), false);
      case RequestPaymentRoute:
        // return MaterialPageRoute(builder: (_) => GenerateScreen());
        final String requesterId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => RequestScreen(
                  requesterId: requesterId,
                ));
      case RequestQRBillRoute:
        final RequestData args = settings.arguments as RequestData;
        return MaterialPageRoute(builder: (_) => RequestQRBillScreen(args));
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
