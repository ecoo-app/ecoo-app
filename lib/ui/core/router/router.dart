import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/screens/creation_verification/wallet_creation_screen.dart';
import 'package:e_coupon/ui/screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/payment/payment_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_qrbill_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_screen.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:e_coupon/ui/screens/start/register_screen.dart';
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
const WalletCreationRoute = 'walletCreation';
const WalletDetailRoute = 'walletDetail';
const WalletsOverviewRoute = 'walletsOverview';
const TransactionOverviewRoute = 'transactionOverview';
const ClaimVerificationRoute = 'claimVerification';
const PaymentRoute = 'payment';
const PaymentOverviewRoute = 'paymentOverview';
const SuccessRoute = 'success';
const RequestPaymentRoute = 'requestPayment';
const RequestQRBillRoute = 'requestQRBill';

abstract class IRouter {
  GlobalKey<NavigatorState> get navigatorKey;

  void pop();

  Future<T> pushNamed<T>(String route, {dynamic arguments});

  Future<void> pushAndRemoveUntil(String route, String until, {dynamic arguments});
}

@Singleton(as: IRouter)
class Router implements IRouter {
  final GlobalKey<NavigatorState> _globalNavKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _globalNavKey;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashRoute:
        return _createRoute(settings, getIt<SplashScreen>(), false);
      case OnboardingRoute:
        return _createRoute(settings, getIt<OnboardingScreen>(), true);
      case RegisterRoute:
        return _createRoute(settings, getIt<RegisterScreen>(), false);
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
        var senderID = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => PaymentScreen(senderID: senderID));
      case PaymentOverviewRoute:
        print('router arguments');
        print(settings.arguments);
        final PaymentOverviewArguments args =
            settings.arguments as PaymentOverviewArguments;
        return MaterialPageRoute(
            // whats the buildcontext? can it be use to have change notifiers from context of screen before?
            builder: (_) => PaymentOverviewScreen(
                  arguments: args,
                ));
      case SuccessRoute:
        return MaterialPageRoute(builder: (_) => SuccessScreen());
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
