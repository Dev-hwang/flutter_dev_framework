import 'package:flutter_dev_framework/logger/model/log_level.dart';

/// 로그 이벤트
class LogEvent {
  final LogLevel level;
  final dynamic message;
  final dynamic detail;
  final dynamic error;
  final dynamic stackTrace;

  const LogEvent({
    required this.level,
    required this.message,
    this.detail,
    this.error,
    this.stackTrace
  });
}
