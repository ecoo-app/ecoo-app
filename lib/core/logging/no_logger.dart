import 'package:e_coupon/core/logging/logger.dart';

class NoLogger extends Logger {
  @override
  void log(LogSeverity severity, String tag, String message) {}

  @override
  void error(String tag, dynamic ex, StackTrace stackTrace) {}
}
