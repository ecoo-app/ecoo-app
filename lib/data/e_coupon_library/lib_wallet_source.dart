import 'package:ecoupon_lib/services/wallet_service.dart';
import 'package:injectable/injectable.dart';

abstract class IWalletSource {
  WalletService get walletService;
}

@LazySingleton(as: IWalletSource)
class WalletSource extends IWalletSource {
  final WalletService service = WalletService();

  WalletService get walletService => service;
}
