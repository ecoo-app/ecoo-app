import 'package:e_coupon/business/entities/wallet.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';

abstract class ILocalWalletSource {
  Future<void> cacheWallet(String key, Wallet wallet);
  Future<void> cacheWallets(String key, List<Wallet> wallets);
  Future<Wallet> getWallet(String key);
  Future<List<Wallet>> getWallets(String key);
}

@injectable
class LocalWalletSource implements ILocalWalletSource {
  final LocalStorage _storage;

  LocalWalletSource(String storageKey) : _storage = LocalStorage(storageKey);

  @override
  Future<void> cacheWallet(String key, Wallet wallet) async {
    await _storage.ready;
    return _storage.setItem(key, wallet);
  }

  @override
  Future<void> cacheWallets(String key, List<Wallet> wallets) async {
    await _storage.ready;
    return _storage.setItem(key, wallets);
  }

  @override
  Future<Wallet> getWallet(String key) async {
    await _storage.ready;
    return _storage.getItem(key);
  }

  @override
  Future<List<Wallet>> getWallets(String key) async {
    await _storage.ready;
    return _storage.getItem(key);
  }
}
