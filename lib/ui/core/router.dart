import 'package:e_coupon/ui/screens/verification/verification_screen.dart';
import 'package:e_coupon/ui/screens/wallet_screens/payment/scan_qr_screen.dart';
import 'package:e_coupon/ui/screens/wallet_screens/wallets/wallet_screen.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// unfortunately routesetting does not allow enums
const HomeRoute = '/';
const WalletDetailRoute = 'walletDetail';
const WalletsOverviewRoute = 'walletsOverview';
const VerificationRoute = 'verification';
const ScanQRRoute = 'scanQR';
// still TODO:
const PaymentRoute = 'payment';
const ShowQRRoute = 'showQR';
const SuccessRoute = 'success';

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
      case ScanQRRoute:
        return MaterialPageRoute(builder: (_) => ScanQRScreen());
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
