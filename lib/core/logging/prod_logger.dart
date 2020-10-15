import 'package:e_coupon/core/logging/logger.dart';
import 'package:e_coupon/injection.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ILogger)
@Environment(Env.prod)
class ProductionLogger extends Logger {
  @override
  void d(String tag, String message) {}

  @override
  void i(String tag, String message) {}

  @override
  void log(LogSeverity severity, String tag, String message) {
    printFormatted(LogSeverity.Exception, '$tag: $message');
  }

  @override
  void error(String tag, dynamic ex, StackTrace stackTrace) {
    printFormatted(LogSeverity.Exception, '$tag: $ex\n$stackTrace');
  }
}
