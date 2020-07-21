// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'business/repo_definitions/abstract_wallet_repo.dart';
import 'business/use_cases/get_all_wallets.dart';
import 'business/use_cases/get_default_wallet.dart';
import 'business/use_cases/get_transactions.dart';
import 'business/use_cases/get_verification_inputs.dart';
import 'business/use_cases/get_wallet.dart';
import 'business/use_cases/handle_transaction.dart';
import 'business/use_cases/verify_claim.dart';
import 'data/lib/lib_wallet_source.dart';
import 'data/lib/mock_library.dart';
import 'data/local/local_wallet_source.dart';
import 'data/network_info.dart';
import 'data/repos/wallet_repo.dart';
import 'device/qr_scanner_mock.dart';
import 'main.dart';
import 'modules/third_party_library_module.dart';
import 'ui/core/router/router.dart';
import 'ui/core/services/abstract_qr_scanner.dart';
import 'ui/core/services/login_service.dart';
import 'ui/core/services/settings_service.dart';
import 'ui/screens/creation_verification/verification_view_model.dart';
import 'ui/screens/payment/payment_overview_view_model.dart';
import 'ui/screens/payment/payment_view_model.dart';
import 'ui/screens/payment/request_view_model.dart';
import 'ui/screens/payment/success_view_model.dart';
import 'ui/screens/start/onboarding_screen.dart';
import 'ui/screens/start/onboarding_screen_view_model.dart';
import 'ui/screens/start/register_screen.dart';
import 'ui/screens/start/register_screen_view_model.dart';
import 'ui/screens/start/splash_screen.dart';
import 'ui/screens/start/splash_screen_view_model.dart';
import 'ui/screens/wallet/wallet_view_model.dart';
import 'ui/screens/wallets_overview/wallets_view_model.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final gh = GetItHelper(g, environment);
  final thirdPartyLibraryModule = _$ThirdPartyLibraryModule();
  gh.lazySingleton<ILibWalletSource>(() => LibWalletSource());
  gh.lazySingleton<ILocalWalletSource>(() => LocalWalletSource());
  gh.factory<ILoginService>(() => LoginService());
  gh.lazySingleton<INetworkInfo>(() => NetworkInfo());
  gh.factory<IQRScanner>(() => MockQRScanner());
  gh.lazySingleton<IWalletRepo>(() => WalletRepo(
        localDataSource: g<ILocalWalletSource>(),
        networkInfo: g<INetworkInfo>(),
        libDataSource: g<ILibWalletSource>(),
      ));
  gh.factory<PaymentViewModel>(() => PaymentViewModel());
  gh.factory<RegisterScreenViewModel>(
      () => RegisterScreenViewModel(g<IRouter>()));
  gh.factory<RequestViewModel>(() => RequestViewModel());
  final sharedPreferences = await thirdPartyLibraryModule.prefs;
  gh.factory<SharedPreferences>(() => sharedPreferences);
  gh.factory<SuccessViewModel>(() => SuccessViewModel());
  gh.lazySingleton<VerifyClaim>(
      () => VerifyClaim(repository: g<IWalletRepo>()));
  gh.factory<ECouponApp>(() => ECouponApp(g<IRouter>()));
  gh.lazySingleton<GetAllWallets>(
      () => GetAllWallets(repository: g<IWalletRepo>()));
  gh.lazySingleton<GetDefaultWallet>(
      () => GetDefaultWallet(repository: g<IWalletRepo>()));
  gh.lazySingleton<GetTransactions>(
      () => GetTransactions(repository: g<IWalletRepo>()));
  gh.lazySingleton<GetVerificationInputs>(
      () => GetVerificationInputs(repository: g<IWalletRepo>()));
  gh.lazySingleton<GetWallet>(() => GetWallet(repository: g<IWalletRepo>()));
  gh.lazySingleton<HandleTransaction>(
      () => HandleTransaction(repository: g<IWalletRepo>()));
  gh.factory<ISettingsService>(() => SettingsService(g<SharedPreferences>()));
  gh.factory<OnboardingScreenViewModel>(
      () => OnboardingScreenViewModel(g<IRouter>(), g<ISettingsService>()));
  gh.factory<PaymentOverviewViewModel>(
      () => PaymentOverviewViewModel(g<HandleTransaction>(), g<IQRScanner>()));
  gh.factory<RegisterScreen>(
      () => RegisterScreen(g<RegisterScreenViewModel>()));
  gh.factory<SplashScreenViewModel>(() => SplashScreenViewModel(
        g<IRouter>(),
        g<ILoginService>(),
        g<ISettingsService>(),
      ));
  gh.lazySingleton<WalletViewModel>(() => WalletViewModel(
      getWallet: g<GetWallet>(), getTransactions: g<GetTransactions>()));
  gh.factory<WalletsViewModel>(
      () => WalletsViewModel(getAllWallets: g<GetAllWallets>()));
  gh.factory<ClaimVerificationViewModel>(() =>
      ClaimVerificationViewModel(g<VerifyClaim>(), g<GetVerificationInputs>()));
  gh.factory<OnboardingScreen>(
      () => OnboardingScreen(g<OnboardingScreenViewModel>()));
  gh.factory<SplashScreen>(() => SplashScreen(g<SplashScreenViewModel>()));

  // Eager singletons must be registered in the right order
  gh.singleton<IRouter>(Router());
}

class _$ThirdPartyLibraryModule extends ThirdPartyLibraryModule {}
