import 'package:e_coupon/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(env) => $initGetIt(getIt, environment: env);

const devEnv = Environment(Env.dev);
const prodEnv = Environment(Env.prod);
const mockEnv = Environment(Env.mock);

abstract class Env {
  static const String dev = 'dev';
  static const String prod = 'prod';
  static const String mock = 'mock';
}
