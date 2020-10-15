import 'package:e_coupon/core/logging/logger.dart';
import 'package:e_coupon/injection.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ILogger)
@Environment(Env.dev)
class DebugLogger extends Logger {
  @override
  void log(LogSeverity severity, String tag, String message) {
    printFormatted(severity, '$tag: $message');
  }

  @override
  void error(String tag, dynamic ex, StackTrace stackTrace) {
    printFormatted(LogSeverity.Exception, '$tag: $ex\n$stackTrace');
  }
}
