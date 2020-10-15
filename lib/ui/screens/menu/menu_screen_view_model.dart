import 'dart:async';

import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/core/logging/logger.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/injection.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/app_service.dart';
import 'package:e_coupon/ui/core/base_view/base_view_model.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/screens/start/onboarding_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class MenuScreenViewModel extends BaseViewModel {
  final ILogger _logger;
  final IAppService _appService;
  final IWalletService _walletService;
  final INetworkInfo _networkInfo;
  final IRouter _router;

  MenuScreenViewModel(this._logger, this._appService, this._router,
      this._walletService, this._networkInfo);

  String get appVersion => _appService.appVersion;

  Future<bool> get isConnected => _networkInfo.isConnected;

  Stream<List<MenuItem>> get wallets => _walletService.walletsStream.transform(
          StreamTransformer<List<WalletEntity>, List<MenuItem>>.fromHandlers(
              handleData: (data, sink) async {
        var menuItems = <MenuItem>[];
        if (await isConnected) {
          menuItems.addAll(data.map((e) => WalletMenuItem(e)));
        } else {
          menuItems.add(NetworkErrorMenuItem());
        }

        menuItems.add(AddWalletMenutItem());
        menuItems.add(OnboardingMenuItem());
        menuItems.add(FaqMenuItem());
        menuItems.add(PrivacyPolicyMenuItem());

        if (_appService.env == Env.dev) {
          menuItems.add(TestCrashMenuItem());
        }

        sink.add(menuItems);
      }));

  Future<void> onboarding() async {
    await _router.pushNamed(OnboardingRoute,
        arguments: OnboardingScreenArguments(true));
  }

  Future<void> close() {
    _router.pop();
    return Future.value();
  }

  WalletEntity get selected => _walletService.getSelected();

  Future<void> init() async {
    await _walletService.fetchAndUpdateWallets();
  }

  Future<void> select(WalletEntity walletEntity) async {
    await _router.pop();
    await _walletService.setSelected(walletEntity);
  }

  Future<void> testException() {
    try {
      throw Exception('This is a TestException');
    } on Exception catch (e, stackTrace) {
      _logger.error('Menu', e, stackTrace);
    }
    return Future.value();
  }
}

class MenuItem {}

class WalletMenuItem implements MenuItem {
  final WalletEntity walletEntity;

  WalletMenuItem(this.walletEntity);
}

class OnboardingMenuItem implements MenuItem {}

class FaqMenuItem implements MenuItem {}

class PrivacyPolicyMenuItem implements MenuItem {}

class AddWalletMenutItem implements MenuItem {}

class NetworkErrorMenuItem implements MenuItem {}

class TestCrashMenuItem implements MenuItem {}
