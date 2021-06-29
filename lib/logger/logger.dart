import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter_dev_framework/logger/model/log_event.dart';
import 'package:flutter_dev_framework/logger/model/log_level.dart';
import 'package:flutter_dev_framework/logger/printer.dart';
import 'package:sentry/sentry.dart';
export 'package:sentry/sentry.dart';

/// [Sentry] 플러그인 모듈이 포함된 Logger
class Logger {
  static final _printer = Printer();

  static SentryEvent _printLog(LogEvent event, bool onlyShowMessage) {
    final log = _printer.log(event, onlyShowMessage: onlyShowMessage);

    String message = '';
    for (var i=0; i<log.length; i++) {
      message += '${log[i].toString()}';
      if (!onlyShowMessage) message += '\n';
    }
    if (!kReleaseMode) dev.log(message);

    return SentryEvent(
      level: event.level.convertSentryLevel,
      message: SentryMessage(message),
      throwable: event.error
    );
  }

  /// [LogLevel.fatal] 수준에서 로그를 출력하고 Sentry 서버로 전송한다.
  static Future<SentryId?> f(dynamic message, {
    dynamic detail,
    dynamic error,
    dynamic stackTrace,
    bool captureEvent = true,
    bool onlyShowMessage = false,
  }) async {
    final logEvent = LogEvent(
        level: LogLevel.fatal,
        message: message,
        detail: detail,
        error: error,
        stackTrace: stackTrace);

    final sentryEvent = _printLog(logEvent, onlyShowMessage);
    if (captureEvent)
      return await Sentry.captureEvent(sentryEvent, stackTrace: stackTrace);

    return null;
  }

  /// [LogLevel.error] 수준에서 로그를 출력하고 Sentry 서버로 전송한다.
  static Future<SentryId?> e(dynamic message, {
    dynamic detail,
    dynamic error,
    dynamic stackTrace,
    bool captureEvent = true,
    bool onlyShowMessage = false,
  }) async {
    final logEvent = LogEvent(
        level: LogLevel.error,
        message: message,
        detail: detail,
        error: error,
        stackTrace: stackTrace);

    final sentryEvent = _printLog(logEvent, onlyShowMessage);
    if (captureEvent)
      return await Sentry.captureEvent(sentryEvent, stackTrace: stackTrace);

    return null;
  }

  /// [LogLevel.warning] 수준에서 로그를 출력하고 Sentry 서버로 전송한다.
  static Future<SentryId?> w(dynamic message, {
    dynamic detail,
    dynamic error,
    dynamic stackTrace,
    bool captureEvent = true,
    bool onlyShowMessage = false,
  }) async {
    final logEvent = LogEvent(
        level: LogLevel.warning,
        message: message,
        detail: detail,
        error: error,
        stackTrace: stackTrace);

    final sentryEvent = _printLog(logEvent, onlyShowMessage);
    if (captureEvent)
      return await Sentry.captureEvent(sentryEvent, stackTrace: stackTrace);

    return null;
  }

  /// [LogLevel.info] 수준에서 로그를 출력하고 Sentry 서버로 전송한다.
  static Future<SentryId?> i(dynamic message, {
    dynamic detail,
    dynamic error,
    dynamic stackTrace,
    bool captureEvent = false,
    bool onlyShowMessage = true,
  }) async {
    final logEvent = LogEvent(
        level: LogLevel.info,
        message: message,
        detail: detail,
        error: error,
        stackTrace: stackTrace);

    final sentryEvent = _printLog(logEvent, onlyShowMessage);
    if (captureEvent)
      return await Sentry.captureEvent(sentryEvent, stackTrace: stackTrace);

    return null;
  }

  /// [LogLevel.debug] 수준에서 로그를 출력하고 Sentry 서버로 전송한다.
  static Future<SentryId?> d(dynamic message, {
    dynamic detail,
    dynamic error,
    dynamic stackTrace,
    bool captureEvent = false,
    bool onlyShowMessage = true,
  }) async {
    final logEvent = LogEvent(
        level: LogLevel.debug,
        message: message,
        detail: detail,
        error: error,
        stackTrace: stackTrace);

    final sentryEvent = _printLog(logEvent, onlyShowMessage);
    if (captureEvent)
      return await Sentry.captureEvent(sentryEvent, stackTrace: stackTrace);

    return null;
  }
}
