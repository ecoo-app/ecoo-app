// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:e_coupon/data/local/local_wallet_source.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/device/qr_scanner_mock.dart';
import 'package:e_coupon/ui/core/services/abstract_qr_scanner.dart';
import 'package:e_coupon/data/repos/wallet_repo.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/screens/payment/payment_view_model.dart';
import 'package:e_coupon/ui/screens/payment/request_view_model.dart';
import 'package:e_coupon/ui/screens/payment/success_view_model.dart';
import 'package:e_coupon/business/use_cases/get_all_wallets.dart';
import 'package:e_coupon/business/use_cases/get_default_wallet.dart';
import 'package:e_coupon/business/use_cases/get_transactions.dart';
import 'package:e_coupon/business/use_cases/get_wallet.dart';
import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/ui/screens/payment/payment_overview_view_model.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_view_model.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<ILocalWalletSource>(() => LocalWalletSource());
  g.registerLazySingleton<INetworkInfo>(() => NetworkInfo());
  g.registerFactory<IQRScanner>(() => MockQRScanner());
  g.registerLazySingleton<IWalletRepo>(() => WalletRepo(
      localDataSource: g<ILocalWalletSource>(),
      networkInfo: g<INetworkInfo>()));
  g.registerFactory<PaymentViewModel>(() => PaymentViewModel());
  g.registerFactory<RequestViewModel>(() => RequestViewModel());
  g.registerFactory<SuccessViewModel>(() => SuccessViewModel());
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
  g.registerFactory<PaymentOverviewViewModel>(
      () => PaymentOverviewViewModel(g<HandleTransaction>(), g<IQRScanner>()));
  g.registerFactory<WalletViewModel>(() => WalletViewModel(
      getWallet: g<GetWallet>(), getTransactions: g<GetTransactions>()));
  g.registerFactory<WalletsViewModel>(
      () => WalletsViewModel(getAllWallets: g<GetAllWallets>()));
}
