import 'package:e_coupon/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(env) => $initGetIt(getIt, environment: env);

abstract class Env {
  static const String dev = 'dev';
  static const String prod = 'prod';
  static const String mock = 'mock';

  static const devEnv = Environment(dev);
  static const prodEnv = Environment(prod);
  static const mockEnv = Environment(mock);
}
