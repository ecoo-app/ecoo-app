import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.iconfig.dart';

final getIt = GetIt.instance;

@injectableInit
void configureInjection(env) => $initGetIt(getIt, environment: env);

abstract class Env {
  static const dev = const Environment('dev');
  static const prod = const Environment('prod');
  static const test = const Environment('test');
}
