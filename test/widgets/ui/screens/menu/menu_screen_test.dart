import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/app_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/screens/menu/menu_screen.dart';
import 'package:e_coupon/ui/screens/menu/menu_screen_view_model.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:ecoupon_lib/models/wallet.dart' as lib_wallet;
import 'package:ecoupon_lib/models/currency.dart' as lib_currency;

import '../../../../helper/widget_test_app.dart';

class AppServiceMock extends Mock implements IAppService {}

class RouterMock extends Mock implements IRouter {}

class WalletRepositoryMock extends Mock implements IWalletRepo {}

class WalletServiceMock extends Mock implements IWalletService {}

class NetworkInfoMock extends Mock implements INetworkInfo {}

void main() {
  Widget _view;
  WidgetTestApp _testApp;

  IRouter _routerMock;
  IAppService _appService;
  IWalletRepo _repositoryMock;
  IWalletService _walletServiceMock;
  INetworkInfo _networkInfoMock;

  tearDown(() {});

  setUp(() {
    _testApp = WidgetTestApp();
    _routerMock = RouterMock();
    _appService = AppServiceMock();
    _repositoryMock = WalletRepositoryMock();
    _walletServiceMock = WalletServiceMock();
    _networkInfoMock = NetworkInfoMock();
    when(_networkInfoMock.isConnected)
        .thenAnswer((realInvocation) => Future.value(true));
    var walletEntity = WalletEntity(lib_wallet.Wallet(
        'TestID',
        'TestKey',
        lib_currency.Currency(
            'wetzicoin', 'wetzicoin', 'CHF', 0, 2, null, null, true, null, 10),
        lib_wallet.WalletCategoy.consumer,
        1000,
        lib_wallet.WalletState.verified));
    when(_repositoryMock.getWallets(any))
        .thenAnswer((realInvocation) => Future.value(Right([walletEntity])));
    when(_walletServiceMock.allWallets)
        .thenAnswer((realInvocation) => Future.value(Right([walletEntity])));

    var walletsViewModel =
        WalletsViewModel(_walletServiceMock, _routerMock, _networkInfoMock);
    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerFactory(() => walletsViewModel);

    var viewModel = MenuScreenViewModel(_appService, _routerMock);

    _view = _testApp.createTestApp(MenuScreen(viewModel));
    when(_appService.appVersion).thenReturn('1.0.0.1');
  });

  testWidgets('menu displays menu items', (WidgetTester tester) async {
    await tester.pumpWidget(_view);

    var menuItems = find.byType(MenuItemWidget);
    expect(menuItems, findsNWidgets(3));
  });

  testWidgets('menu shows app version', (WidgetTester tester) async {
    await tester.pumpWidget(_view);

    var item = find.text('1.0.0.1');
    expect(item, findsOneWidget);
  });

  testWidgets('menu shows tezos logo', (WidgetTester tester) async {
    await tester.pumpWidget(_view);

    var item = find.text('Tezos');
    expect(item, findsOneWidget);
  });
}
