import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/data/e_coupon_library/mock_data.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:e_coupon/data/repos/abstract_wallet_repo.dart';
import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/app_service.dart';
import 'package:e_coupon/ui/core/services/wallet_service.dart';
import 'package:e_coupon/ui/screens/menu/menu_screen.dart';
import 'package:e_coupon/ui/screens/menu/menu_screen_view_model.dart';
import 'package:ecoupon_lib/models/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ecoupon_lib/models/wallet.dart' as lib_wallet;
import 'package:ecoupon_lib/models/currency.dart' as lib_currency;

import '../../../../helper/mock_implementations.dart';
import '../../../../helper/widget_test_app.dart';

void main() {
  Widget _view;
  WidgetTestApp _testApp;

  IRouter _routerMock;
  IAppService _appService;
  IWalletRepo _repositoryMock;
  IWalletService _walletServiceMock;
  INetworkInfo _networkInfoMock;

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
        lib_wallet.WalletCategory.consumer,
        1000,
        lib_wallet.WalletState.verified,
        1));
    when(_repositoryMock.getWallets(any))
        .thenAnswer((realInvocation) => Future.value(Right([walletEntity])));
    final testWallet = WalletEntity(Wallet(
      PrivateWalletID,
      PrivatePublicKey,
      MockWetzikonCurrency(),
      WalletCategory.consumer,
      105,
      WalletState.verified,
      1,
    ));
    final stream = StreamController<List<WalletEntity>>(sync: true);
    stream.add([testWallet]);

    when(_walletServiceMock.getSelected()).thenReturn(testWallet);

    when(_walletServiceMock.walletsStream)
        .thenAnswer((realInvocation) => stream.stream);

    var viewModel = MenuScreenViewModel(
        _appService, _routerMock, _walletServiceMock, _networkInfoMock);

    _view = _testApp.createTestApp(MenuScreen(viewModel));
    when(_appService.appVersion).thenReturn('1.0.0.1');
  });

  testWidgets('menu displays menu items', (WidgetTester tester) async {
    await tester.pumpWidget(_view);
    await tester.pump(Duration.zero);

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
