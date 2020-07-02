// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:e_coupon/data/local/scanner_repo.dart';
import 'package:e_coupon/business/repo_definitions/abstract_scanner_repo.dart';
import 'package:e_coupon/data/wallet_repo.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:e_coupon/business/use_cases/scan_qr.dart';
import 'package:e_coupon/business/use_cases/get_all_wallets.dart';
import 'package:e_coupon/business/use_cases/get_transactions.dart';
import 'package:e_coupon/business/use_cases/get_wallet.dart';
import 'package:e_coupon/business/use_cases/handle_transaction.dart';
import 'package:e_coupon/ui/screens/wallet_screens/payment/transaction_view_model.dart';
import 'package:e_coupon/ui/screens/wallet_screens/wallet_view_model.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<IScannerRepo>(() => ScannerRepo());
  g.registerLazySingleton<IWalletRepo>(() => WalletRepo());
  g.registerLazySingleton<ScanQR>(() => ScanQR(repository: g<IScannerRepo>()));
  g.registerLazySingleton<GetAllWallets>(
      () => GetAllWallets(repository: g<IWalletRepo>()));
  g.registerLazySingleton<GetTransactions>(
      () => GetTransactions(repository: g<IWalletRepo>()));
  g.registerLazySingleton<GetWallet>(
      () => GetWallet(repository: g<IWalletRepo>()));
  g.registerLazySingleton<HandleTransaction>(
      () => HandleTransaction(repository: g<IWalletRepo>()));
  g.registerFactory<TransactionViewModel>(
      () => TransactionViewModel(handleTransaction: g<HandleTransaction>()));
  g.registerFactory<WalletViewModel>(() => WalletViewModel(
      getWallet: g<GetWallet>(), getTransactions: g<GetTransactions>()));
  g.registerFactory<WalletsViewModel>(
      () => WalletsViewModel(getAllWallets: g<GetAllWallets>()));
}
