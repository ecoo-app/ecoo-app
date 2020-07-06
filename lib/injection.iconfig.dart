// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:e_coupon/device/qr_scanner_mock.dart';
import 'package:e_coupon/ui/core/abstract_qr_scanner.dart';
import 'package:e_coupon/data/repos/wallet_repo.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/data/repos/mock_wallet_repo.dart';
import 'package:e_coupon/business/use_cases/get_all_wallets.dart';
import 'package:e_coupon/business/use_cases/get_default_wallet.dart';
import 'package:e_coupon/business/use_cases/get_transactions.dart';
import 'package:e_coupon/business/use_cases/get_wallet.dart';
import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:e_coupon/ui/screens/wallet_screens/payment/transaction_view_model.dart';
import 'package:e_coupon/ui/core/base_view_model.dart';
import 'package:e_coupon/ui/screens/wallet_screens/wallet_view_model.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<IQRScanner>(() => MockQRScanner());
  g.registerLazySingleton<GetAllWallets>(
      () => GetAllWallets(repository: g<IWalletRepo>()));
  g.registerLazySingleton<GetDefaultWallet>(
      () => GetDefaultWallet(repository: g<IWalletRepo>()));
  g.registerLazySingleton<GetTransactions>(
      () => GetTransactions(repository: g<IWalletRepo>()));
  g.registerLazySingleton<GetWallet>(
      () => GetWallet(repository: g<IWalletRepo>()));
  g.registerLazySingleton<HandleTransaction>(
      () => HandleTransaction(repository: g<IWalletRepo>()));
  g.registerFactory<WalletsViewModel>(
      () => WalletsViewModel(getAllWallets: g<GetAllWallets>()));
  g.registerFactory<BaseViewModel>(
      () => TransactionViewModel(
          handleTransaction: g<HandleTransaction>(),
          qrScanner: g<IQRScanner>()),
      instanceName: 'TransactionViewModel');
  g.registerFactory<BaseViewModel>(
      () => WalletViewModel(
          getWallet: g<GetWallet>(), getTransactions: g<GetTransactions>()),
      instanceName: 'WalletViewModel');

  //Register dev Dependencies --------
  if (environment == 'dev') {
    g.registerLazySingleton<IWalletRepo>(() => WalletRepo());
  }

  //Register mock Dependencies --------
  if (environment == 'mock') {
    g.registerLazySingleton<IWalletRepo>(() => MockWalletRepo());
  }
}
