import 'package:e_coupon/injection.dart';
import 'package:ecoupon_lib/services/wallet_service.dart';
import 'package:injectable/injectable.dart';

abstract class IWalletSource {
  WalletService get walletService;
}

@LazySingleton(as: IWalletSource)
@Environment(Env.dev)
class WalletSourceDev extends IWalletSource {
  final WalletService service =
      WalletService('https://ecoupon-backend.prod.gke.papers.tech');

  WalletService get walletService => service;
}

@LazySingleton(as: IWalletSource)
@Environment(Env.prod)
class WalletSourceProd extends IWalletSource {
  final WalletService service = WalletService();

  WalletService get walletService => service;
}
