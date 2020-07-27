import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/lib/mock_data.dart';
import 'package:injectable/injectable.dart';

abstract class IWalletService {
  WalletEntity get selectedWallet;
}

@LazySingleton(as: IWalletService)
class WalletService extends IWalletService {
  @override
  WalletEntity get selectedWallet => WalletEntity(privateWalletMock);
}
