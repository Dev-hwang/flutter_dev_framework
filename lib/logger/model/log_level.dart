import 'package:sentry/sentry.dart';

/// 로그 레벨
enum LogLevel {
  fatal,
  error,
  warning,
  info,
  debug
}

/// 로그 레벨 기능 확장
extension LogLevelExtension on LogLevel {
  /// [LogLevel]을 [SentryLevel]로 변환하여 반환한다.
  SentryLevel get convertSentryLevel {
    switch (this) {
      case LogLevel.fatal:
        return SentryLevel.fatal;
      case LogLevel.error:
        return SentryLevel.error;
      case LogLevel.warning:
        return SentryLevel.warning;
      case LogLevel.info:
        return SentryLevel.info;
      case LogLevel.debug:
        return SentryLevel.debug;
    }
  }
}
