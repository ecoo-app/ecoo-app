// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:e_coupon/data/wallet_repo.dart';
import 'package:e_coupon/business/abstract_wallet_repo.dart';
import 'package:e_coupon/business/get_all_wallets.dart';
import 'package:e_coupon/business/get_wallet.dart';
import 'package:e_coupon/ui/screens/wallet_screens/wallet_view_model.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<IWalletRepo>(() => WalletRepo());
  g.registerLazySingleton<GetAllWallets>(
      () => GetAllWallets(repository: g<IWalletRepo>()));
  g.registerLazySingleton<GetWallet>(
      () => GetWallet(repository: g<IWalletRepo>()));
  g.registerFactory<WalletViewModel>(
      () => WalletViewModel(getWallet: g<GetWallet>()));
  g.registerFactory<WalletsViewModel>(
      () => WalletsViewModel(getAllWallets: g<GetAllWallets>()));
}
