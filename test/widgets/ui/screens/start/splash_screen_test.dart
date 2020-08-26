import 'package:e_coupon/ui/core/router/router.dart';
import 'package:e_coupon/ui/core/services/login_service.dart';
import 'package:e_coupon/ui/core/services/notification_service.dart';
import 'package:e_coupon/ui/core/services/settings_service.dart';
import 'package:e_coupon/ui/screens/start/splash_screen.dart';
import 'package:e_coupon/ui/screens/start/splash_screen_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/mock_implementations.dart';
import '../../../../helper/widget_test_app.dart';



void main() {
  Widget _view;
  WidgetTestApp _testApp;

  IRouter _routerMock;
  ILoginService _loginService;
  INotificationService _notificationServiceMock;
  ISettingsService _settingsServiceMock;

  setUp(() {
    _testApp = WidgetTestApp();
    _routerMock = RouterMock();
    _loginService = LoginServiceMock();
    _notificationServiceMock = NotificationServiceMock();
    _settingsServiceMock = SettingsServiceMock();

    var viewModel = SplashScreenViewModel(_routerMock, _loginService,
        _notificationServiceMock, _settingsServiceMock);

    _view = _testApp.createTestApp(SplashScreen(viewModel));
  });

  testWidgets('splashscreen renders screen content',
      (WidgetTester tester) async {
    await tester.pumpWidget(_view);
    await tester.pump();

    expect(find.byType(SvgPicture), findsNWidgets(2));
    expect(find.text('ecoo'), findsOneWidget);
    expect(find.text('Tezos'), findsOneWidget);
  });
}
