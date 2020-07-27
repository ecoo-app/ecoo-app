import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/lib/mock_data.dart';
import 'package:injectable/injectable.dart';

abstract class IWalletService {
  List<WalletEntity> get wallets;
  WalletEntity get selectedWallet;
  set selected(WalletEntity wallet);
}

@LazySingleton(as: IWalletService)
class WalletService implements IWalletService {
  List<WalletEntity> _wallets = MockWallets;
  WalletEntity _selected = WalletEntity(privateWalletMock);

  @override
  WalletEntity get selectedWallet => this._selected;

  @override
  List<WalletEntity> get wallets => this._wallets;

  @override
  set selected(WalletEntity wallet) {
    this._selected = wallet;
  }
}
