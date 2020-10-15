import 'dart:async';
import 'dart:isolate';

import 'package:e_coupon/injection.dart';
import 'package:e_coupon/main.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'core/logging/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Env.prod);

  var app = getIt.get<ECouponApp>();
  var logger = getIt.get<ILogger>();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runZoned(() => runApp(app), onError: (ex, stackTrace) {
      try {
        logger.error('Unhandled', ex, stackTrace);
      } catch (e) {
        logger.e('Application', 'Unhandled $e , Error: $ex');
        rethrow;
      }
    });
  });

  FlutterError.onError = (details, {bool forceReport = false}) {
    try {
      logger.error('FlutterError', details.exception, details.stack);
    } catch (e) {
      logger.e(
          'Application', 'Flutter Error: $e , Error: ${details.exception}');
      FirebaseCrashlytics.instance.recordFlutterError(details);
    } finally {
      FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    }
  };

  Isolate.current.addErrorListener(RawReceivePort((pair) {
    final List<dynamic> errorAndStacktrace = pair;
    try {
      logger.error(
          'Application', errorAndStacktrace.first, errorAndStacktrace.last);
    } catch (e) {
      logger.e('Application',
          'Unhandled ${errorAndStacktrace.first} , Error: ${errorAndStacktrace.last}');
    }
  }).sendPort);
}
