abstract class ILogger {
  void log(LogSeverity severity, String tag, String message);

  void error(String tag, dynamic ex, StackTrace stackTrace);

  void d(String tag, String message);

  void i(String tag, String message);

  void w(String tag, String message);

  void e(String tag, String message);
}

abstract class Logger implements ILogger {
  @override
  void d(String tag, String message) {
    log(LogSeverity.Debug, tag, message);
  }

  @override
  void i(String tag, String message) {
    log(LogSeverity.Info, tag, message);
  }

  @override
  void w(String tag, String message) {
    log(LogSeverity.Warning, tag, message);
  }

  @override
  void e(String tag, String message) {
    log(LogSeverity.Error, tag, message);
  }

  void printFormatted(LogSeverity severity, String message) {
    var currentTime = DateTime.now();
    print('[$currentTime] [${severity.toEnumString()}] $message');
  }
}

enum LogSeverity { Trace, Debug, Info, Warning, Error, Exception }

extension LogSeverityExtension on LogSeverity {
  String toEnumString() {
    return '${toString().substring(toString().indexOf('.') + 1)}';
  }
}
