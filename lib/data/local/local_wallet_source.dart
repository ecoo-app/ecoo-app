import 'dart:convert';

import 'package:e_coupon/business/entities/wallet.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';

const walletsKey = 'wallets';
const singleWalletKey = 'wallet';
const transactionsKey = 'transactions';

abstract class ILocalWalletSource {
  Future<void> cacheWallet(String key, IWalletEntity wallet);
  Future<void> cacheWallets(String key, List<IWalletEntity> wallets);
  Future<IWalletEntity> getWallet(String key);
  Future<List<IWalletEntity>> getWallets(String key);
}

@LazySingleton(as: ILocalWalletSource)
class LocalWalletSource implements ILocalWalletSource {
  final LocalStorage _storage;

  LocalWalletSource(this._storage);

  @override
  Future<void> cacheWallet(String key, IWalletEntity wallet) async {
    await _storage.ready;
    return _storage.setItem(key, wallet.libWallet.toJson());
  }

  String _walletsToJson(List<IWalletEntity> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.libWallet.toJson())));

  @override
  Future<void> cacheWallets(String key, List<IWalletEntity> wallets) async {
    await _storage.ready;
    return _storage.setItem(key, _walletsToJson(wallets));
  }

  @override
  Future<IWalletEntity> getWallet(String key) async {
    await _storage.ready;
    //var walletJson = await _storage.getItem(key);
    // return WetzikonWalletEntity(Wallet.fromJson(walletJson));
    throw UnimplementedError();
  }

  // List<IWalletEntity> _walletsFromJson(String str) => List<IWalletEntity>.from(
  //     json.decode(str).map((x) => WetzikonWalletEntity(Wallet.fromJson(x))));

  @override
  Future<List<IWalletEntity>> getWallets(String key) async {
    await _storage.ready;
    //var result = _storage.getItem(key);
    throw UnimplementedError();
    // return _walletsFromJson(result);
  }
}
