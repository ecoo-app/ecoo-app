// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'business/repo_definitions/abstract_wallet_repo.dart';
import 'business/use_cases/get_all_wallets.dart';
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
import 'ui/core/services/app_service.dart';
import 'ui/core/services/camera_service.dart';
import 'ui/core/services/login_service.dart';
import 'ui/core/services/qr_scan_parser.dart';
import 'ui/core/services/settings_service.dart';
import 'ui/core/services/transfer_service.dart';
import 'ui/core/services/wallet_scervice.dart';
import 'ui/screens/creation_verification/verification_view_model.dart';
import 'ui/screens/menu/menu_screen.dart';
import 'ui/screens/menu/menu_screen_view_model.dart';
import 'ui/screens/payment/error_screen.dart';
import 'ui/screens/payment/payment_screen.dart';
import 'ui/screens/payment/payment_view_model.dart';
import 'ui/screens/payment/qr_scanner_view_model.dart';
import 'ui/screens/payment/request_view_model.dart';
import 'ui/screens/payment/success_view_model.dart';
import 'ui/screens/register/register_screen.dart';
import 'ui/screens/register/register_screen_view_model.dart';
import 'ui/screens/register/register_verifiy_screen.dart';
import 'ui/screens/register/register_verify_screen_view_model.dart';
import 'ui/screens/register/register_wallet_type_screen.dart';
import 'ui/screens/register/register_wallet_type_screen_view_model.dart';
import 'ui/screens/start/onboarding_screen.dart';
import 'ui/screens/start/onboarding_screen_view_model.dart';
import 'ui/screens/start/splash_screen.dart';
import 'ui/screens/start/splash_screen_view_model.dart';
import 'ui/screens/wallet/wallet_view_model.dart';
import 'ui/screens/wallets_overview/wallets_view_model.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final gh = GetItHelper(g, environment);
  final thirdPartyLibraryModule = _$ThirdPartyLibraryModule();
  gh.factory<ErrorScreen>(() => ErrorScreen());
  gh.lazySingleton<ICameraService>(() => CameraService());
  gh.lazySingleton<ILibWalletSource>(() => LibWalletSource());
  gh.lazySingleton<ILocalWalletSource>(() => LocalWalletSource());
  gh.factory<ILoginService>(() => LoginService());
  gh.lazySingleton<INetworkInfo>(() => NetworkInfo());
  gh.lazySingleton<IQRScanParser>(() => MockQRScanParser());
  gh.factory<IQRScanner>(() => MockQRScanner());
  gh.lazySingleton<ITransferService>(() => TransferService());
  gh.lazySingleton<IWalletService>(() => WalletService());
  gh.lazySingleton<IWalletSource>(() => WalletSource());
  final packageInfo = await thirdPartyLibraryModule.packageInfo;
  gh.factory<PackageInfo>(() => packageInfo);
  gh.factory<PaymentScreen>(() => PaymentScreen());
  gh.factory<QRScannerViewModel>(
      () => QRScannerViewModel(g<ICameraService>(), g<IRouter>()));
  gh.factory<RegisterScreenViewModel>(
      () => RegisterScreenViewModel(g<IRouter>()));
  gh.factory<RegisterVerifyScreenViewModel>(
      () => RegisterVerifyScreenViewModel(g<IRouter>()));
  gh.factory<RegisterWalletTypeScreenViewModel>(
      () => RegisterWalletTypeScreenViewModel(g<IRouter>()));
  gh.factory<RequestViewModel>(() => RequestViewModel());
  final sharedPreferences = await thirdPartyLibraryModule.prefs;
  gh.factory<SharedPreferences>(() => sharedPreferences);
  gh.factory<SuccessViewModel>(() => SuccessViewModel());
  gh.factory<ECouponApp>(() => ECouponApp(g<IRouter>()));
  gh.factory<IAppService>(() => AppService(g<PackageInfo>()));
  gh.factory<ISettingsService>(() => SettingsService(g<SharedPreferences>()));
  gh.lazySingleton<IWalletRepo>(() => WalletRepo(
        localDataSource: g<ILocalWalletSource>(),
        networkInfo: g<INetworkInfo>(),
        libDataSource: g<ILibWalletSource>(),
        walletSource: g<IWalletSource>(),
      ));
  gh.factory<MenuScreenViewModel>(
      () => MenuScreenViewModel(g<IAppService>(), g<IRouter>()));
  gh.factory<OnboardingScreenViewModel>(
      () => OnboardingScreenViewModel(g<IRouter>(), g<ISettingsService>()));
  gh.factory<RegisterScreen>(
      () => RegisterScreen(g<RegisterScreenViewModel>()));
  gh.factory<RegisterVerifyScreen>(
      () => RegisterVerifyScreen(g<RegisterVerifyScreenViewModel>()));
  gh.factory<RegisterWalletTypeScreen>(
      () => RegisterWalletTypeScreen(g<RegisterWalletTypeScreenViewModel>()));
  gh.factory<SplashScreenViewModel>(() => SplashScreenViewModel(
        g<IRouter>(),
        g<ILoginService>(),
        g<ISettingsService>(),
      ));
  gh.lazySingleton<VerifyClaim>(
      () => VerifyClaim(repository: g<IWalletRepo>()));
  gh.lazySingleton<GetAllWallets>(
      () => GetAllWallets(repository: g<IWalletRepo>()));
  gh.lazySingleton<GetTransactions>(
      () => GetTransactions(repository: g<IWalletRepo>()));
  gh.lazySingleton<GetVerificationInputs>(
      () => GetVerificationInputs(repository: g<IWalletRepo>()));
  gh.lazySingleton<GetWallet>(() => GetWallet(repository: g<IWalletRepo>()));
  gh.lazySingleton<HandleTransaction>(
      () => HandleTransaction(repository: g<IWalletRepo>()));
  gh.factory<MenuScreen>(() => MenuScreen(g<MenuScreenViewModel>()));
  gh.factory<OnboardingScreen>(
      () => OnboardingScreen(g<OnboardingScreenViewModel>()));
  gh.factory<PaymentViewModel>(() => PaymentViewModel(
        g<IRouter>(),
        g<IQRScanner>(),
        g<IWalletService>(),
        g<HandleTransaction>(),
      ));
  gh.factory<SplashScreen>(() => SplashScreen(g<SplashScreenViewModel>()));
  gh.lazySingleton<WalletViewModel>(() => WalletViewModel(
        g<GetWallet>(),
        g<GetTransactions>(),
        g<IRouter>(),
      ));
  gh.factory<WalletsViewModel>(
      () => WalletsViewModel(getAllWallets: g<GetAllWallets>()));
  gh.factory<ClaimVerificationViewModel>(() =>
      ClaimVerificationViewModel(g<VerifyClaim>(), g<GetVerificationInputs>()));

  // Eager singletons must be registered in the right order
  gh.singleton<IRouter>(Router());
}

class _$ThirdPartyLibraryModule extends ThirdPartyLibraryModule {}
