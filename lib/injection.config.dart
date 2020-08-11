// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repos/dev_wallet_repo.dart';
import 'main.dart';
import 'ui/screens/payment/error_screen.dart';
import 'ui/core/services/app_service.dart';
import 'data/local/local_wallet_source.dart';
import 'ui/core/services/login_service.dart';
import 'data/network_info.dart';
import 'ui/core/services/qr_scan_parser.dart';
import 'ui/core/router/router.dart';
import 'ui/core/services/settings_service.dart';
import 'ui/core/services/transfer_service.dart';
import 'data/repos/abstract_wallet_repo.dart';
import 'ui/core/services/wallet_service.dart';
import 'data/e_coupon_library/lib_wallet_source.dart';
import 'ui/screens/menu/menu_screen.dart';
import 'ui/screens/menu/menu_screen_view_model.dart';
import 'ui/core/services/mock_login_service.dart';
import 'data/mock_network_info.dart';
import 'data/repos/mock_wallet_repo.dart';
import 'ui/screens/start/onboarding_screen.dart';
import 'ui/screens/start/onboarding_screen_view_model.dart';
import 'ui/screens/payment/payment_screen.dart';
import 'ui/screens/payment/payment_view_model.dart';
import 'ui/screens/verification/pin_verification_screen.dart';
import 'ui/screens/verification/pin_verification_view_model.dart';
import 'ui/screens/payment/qrbill_view_model.dart';
import 'ui/screens/payment/qr_scanner_view_model.dart';
import 'ui/screens/redeem/redeem_screen.dart';
import 'ui/screens/redeem/redeem_view_model.dart';
import 'ui/screens/register/register_screen.dart';
import 'ui/screens/register/register_screen_view_model.dart';
import 'ui/screens/register/register_verifiy_screen.dart';
import 'ui/screens/register/register_verify_screen_view_model.dart';
import 'ui/screens/register/register_wallet_type_screen.dart';
import 'ui/screens/register/register_wallet_type_screen_view_model.dart';
import 'ui/screens/payment/request_qrbill_screen.dart';
import 'ui/screens/payment/request_screen.dart';
import 'ui/screens/payment/request_view_model.dart';
import 'ui/screens/start/splash_screen.dart';
import 'ui/screens/start/splash_screen_view_model.dart';
import 'ui/screens/payment/success_view_model.dart';
import 'modules/third_party_library_module.dart';
import 'ui/screens/verification/verification_screen.dart';
import 'ui/screens/verification/verification_view_model.dart';
import 'ui/screens/wallet/qr_overlay.dart';
import 'data/repos/wallet_repo.dart';
import 'ui/screens/wallet/wallet_view_model.dart';
import 'ui/screens/wallets_overview/wallets_view_model.dart';

/// Environment names
const _dev = 'dev';
const _mock = 'mock';
const _prod = 'prod';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyLibraryModule = _$ThirdPartyLibraryModule();
  gh.factory<ErrorScreen>(() => ErrorScreen());
  gh.lazySingleton<ILocalWalletSource>(() => LocalWalletSource());
  gh.factory<ILoginService>(() => LoginService());
  gh.lazySingleton<INetworkInfo>(() => MockNetworkInfo(),
      registerFor: {_dev, _mock});
  gh.lazySingleton<INetworkInfo>(() => NetworkInfo(), registerFor: {_prod});
  gh.lazySingleton<IQRScanParser>(() => QRScanParser());
  gh.lazySingleton<ITransferService>(() => TransferService());
  gh.lazySingleton<IWalletSource>(() => WalletSource());
  gh.lazySingleton<MockLoginService>(
      () => MockLoginService(get<IWalletSource>()));
  gh.lazySingleton<MockWalletRepo>(() => MockWalletRepo(
        localDataSource: get<ILocalWalletSource>(),
        networkInfo: get<INetworkInfo>(),
        walletSource: get<IWalletSource>(),
      ));
  final packageInfo = await thirdPartyLibraryModule.packageInfo;
  gh.factory<PackageInfo>(() => packageInfo);
  gh.factory<PaymentScreen>(() => PaymentScreen());
  gh.factory<RegisterScreenViewModel>(
      () => RegisterScreenViewModel(get<IRouter>()));
  gh.factory<RegisterVerifyScreenViewModel>(
      () => RegisterVerifyScreenViewModel(get<IRouter>()));
  gh.factory<RequestQRBillScreen>(() => RequestQRBillScreen());
  gh.factory<RequestScreen>(() => RequestScreen());
  final sharedPreferences = await thirdPartyLibraryModule.prefs;
  gh.factory<SharedPreferences>(() => sharedPreferences);
  gh.factory<SuccessViewModel>(() => SuccessViewModel());
  gh.factory<VerificationViewModel>(() => VerificationViewModel());
  gh.factory<WalletQROverlay>(() => WalletQROverlay());
  gh.lazySingleton<WalletRepo>(() => WalletRepo(
        localDataSource: get<ILocalWalletSource>(),
        networkInfo: get<INetworkInfo>(),
        walletSource: get<IWalletSource>(),
      ));
  gh.factory<ECouponApp>(() => ECouponApp(get<IRouter>()));
  gh.factory<IAppService>(() => AppService(get<PackageInfo>()));
  gh.factory<ISettingsService>(() => SettingsService(get<SharedPreferences>()));
  gh.lazySingleton<IWalletRepo>(
      () => DevWalletRepo(get<ILocalWalletSource>(), get<MockLoginService>()),
      registerFor: {_dev});
  gh.lazySingleton<IWalletService>(
      () => WalletService(get<IWalletRepo>(), get<ISettingsService>()));
  gh.factory<MenuScreenViewModel>(
      () => MenuScreenViewModel(get<IAppService>(), get<IRouter>()));
  gh.factory<OnboardingScreenViewModel>(
      () => OnboardingScreenViewModel(get<IRouter>(), get<ISettingsService>()));
  gh.factory<PaymentViewModel>(() => PaymentViewModel(
        get<IRouter>(),
        get<IWalletService>(),
        get<ITransferService>(),
        get<IWalletRepo>(),
      ));
  gh.factory<PinVerificationViewModel>(() => PinVerificationViewModel(
        get<IWalletService>(),
        get<IWalletSource>(),
        get<IRouter>(),
      ));
  gh.factory<QRBillViewModel>(() => QRBillViewModel(
        get<ITransferService>(),
        get<IRouter>(),
        get<IWalletService>(),
      ));
  gh.factory<QRScannerViewModel>(() => QRScannerViewModel(
        get<IRouter>(),
        get<ITransferService>(),
        get<IQRScanParser>(),
        get<IWalletService>(),
      ));
  gh.factory<RedeemViewModel>(
      () => RedeemViewModel(get<IWalletService>(), get<IRouter>()));
  gh.factory<RegisterScreen>(
      () => RegisterScreen(get<RegisterScreenViewModel>()));
  gh.factory<RegisterVerifyScreen>(
      () => RegisterVerifyScreen(get<RegisterVerifyScreenViewModel>()));
  gh.factory<RegisterWalletTypeScreenViewModel>(
      () => RegisterWalletTypeScreenViewModel(
            get<IRouter>(),
            get<IWalletService>(),
            get<IWalletRepo>(),
          ));
  gh.factory<RequestViewModel>(() => RequestViewModel(
        get<ITransferService>(),
        get<IWalletService>(),
        get<IRouter>(),
      ));
  gh.factory<SplashScreenViewModel>(() => SplashScreenViewModel(
        get<IRouter>(),
        get<ILoginService>(),
        get<ISettingsService>(),
      ));
  gh.factory<VerificationScreen>(
      () => VerificationScreen(get<VerificationViewModel>()));
  gh.lazySingleton<WalletViewModel>(() => WalletViewModel(
        get<IRouter>(),
        get<IWalletService>(),
        get<MockLoginService>(),
      ));
  gh.factory<WalletsViewModel>(() => WalletsViewModel(get<IWalletService>()));
  gh.factory<MenuScreen>(() => MenuScreen(get<MenuScreenViewModel>()));
  gh.factory<OnboardingScreen>(
      () => OnboardingScreen(get<OnboardingScreenViewModel>()));
  gh.factory<PinVerificationScreen>(
      () => PinVerificationScreen(get<PinVerificationViewModel>()));
  gh.factory<RedeemScreen>(() => RedeemScreen(get<RedeemViewModel>()));
  gh.factory<RegisterWalletTypeScreen>(
      () => RegisterWalletTypeScreen(get<RegisterWalletTypeScreenViewModel>()));
  gh.factory<SplashScreen>(() => SplashScreen(get<SplashScreenViewModel>()));

  // Eager singletons must be registered in the right order
  gh.singleton<IRouter>(Router());
  return get;
}

class _$ThirdPartyLibraryModule extends ThirdPartyLibraryModule {}
