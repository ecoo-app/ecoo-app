import 'package:e_coupon/ui/screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/payment/payment_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_qrbill_screen.dart';
import 'package:e_coupon/ui/screens/payment/request_screen.dart';
import 'package:e_coupon/ui/screens/payment/success_screen.dart';
import 'package:e_coupon/ui/screens/payment/transaction_data.dart';
import 'package:e_coupon/ui/screens/verification/verification_screen.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_screen.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_overview.dart';
import 'package:e_coupon/ui/spikes/qrGeneratorTest_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// unfortunately routesetting does not allow enums
const HomeRoute = '/';
const WalletDetailRoute = 'walletDetail';
const WalletsOverviewRoute = 'walletsOverview';
const VerificationRoute = 'verification';
const PaymentRoute = 'payment';
const PaymentOverviewRoute = 'paymentOverview';
const SuccessRoute = 'success';
const RequestPaymentRoute = 'requestPayment';
const RequestQRBillRoute = 'requestQRBill';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoute:
      case WalletDetailRoute:
        var walletId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => WalletScreen(walletId: walletId));
      case WalletsOverviewRoute:
        // var post = settings.arguments as Post;
        // return MaterialPageRoute(builder: (_) => WalletScreen(post: post));
        return MaterialPageRoute(builder: (_) => WalletsOverviewScreen());
      case VerificationRoute:
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
}
