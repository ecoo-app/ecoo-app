import 'package:e_coupon/business/entities/wallet.dart';
import 'package:ecoupon_lib/models/wallet.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';

const walletsKey = 'wallets';
const singleWalletKey = 'wallet';
const transactionsKey = 'transactions';

abstract class ILocalWalletSource {
  Future<void> cacheWallet(String key, WalletEntity wallet);
  Future<void> cacheWallets(String key, List<WalletEntity> wallets);
  Future<WalletEntity> getWallet(String key);
  Future<List<WalletEntity>> getWallets(String key);
}

@LazySingleton(as: ILocalWalletSource)
class LocalWalletSource implements ILocalWalletSource {
  final LocalStorage _storage;

  LocalWalletSource() : _storage = LocalStorage('storageKey');

  @override
  Future<void> cacheWallet(String key, WalletEntity wallet) async {
    await _storage.ready;
    //
    return _storage.setItem(key, wallet.walletModel.toJson());
  }

  @override
  Future<void> cacheWallets(String key, List<WalletEntity> wallets) async {
    await _storage.ready;
    // TODO
    return _storage.setItem(key, {});
  }

  @override
  Future<WalletEntity> getWallet(String key) async {
    await _storage.ready;
    var walletJson = await _storage.getItem(key);
    return WalletEntity(Wallet.fromJson(walletJson));
  }

  @override
  Future<List<WalletEntity>> getWallets(String key) async {
    await _storage.ready;
    return _storage.getItem(key);
  }
}
