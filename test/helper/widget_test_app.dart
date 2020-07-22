import 'package:e_coupon/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/mockito.dart';

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

class WidgetTestApp {
  Widget createTestApp(Widget widgetUnderTest) {
    return MaterialApp(
      home: widgetUnderTest,
      supportedLocales: [
        const Locale('de', ''),
      ],
      localizationsDelegates: [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      onGenerateRoute: _getPageRoute,
    );
  }

  MaterialPageRoute _createRoute(
      RouteSettings settings, Widget builder, bool fullscreenDialog) {
    return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => builder,
        fullscreenDialog: fullscreenDialog);
  }

  Route _getPageRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return _createRoute(settings, createDefaultScafold(), false);
    }
  }

  Widget createDefaultScafold() {
    return Scaffold();
  }
}
