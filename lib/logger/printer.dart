import 'dart:convert';
import 'package:flutter_dev_framework/logger/model/log_event.dart';
import 'package:flutter_dev_framework/logger/model/log_level.dart';

/// 예쁘게 정리된 로그를 생성해 주는 Printer
class Printer {
  static const _topLeftCorner = '┌';
  static const _bottomLeftCorner = '└';
  static const _middleCorner = '├';
  static const _verticalLine = '│';
  static const _doubleDivider = '─';
  static const _singleDivider = '┄';

  static final _deviceStackTraceRegex = RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');
  static final _webStackTraceRegex = RegExp(r'^((packages|dart-sdk)\/[^\s]+\/)');
  static final _browserStackTraceRegex = RegExp(r'^(?:package:)?(dart:[^\s]+|[^\s]+)');

  final int stackTraceBeginIndex;
  final int methodCount;
  final int errorMethodCount;
  final int lineLength;

  String _topBorder = '';
  String _middleBorder = '';
  String _bottomBorder = '';

  Printer({
    this.stackTraceBeginIndex = 0,
    this.methodCount = 10,
    this.errorMethodCount = 10,
    this.lineLength = 100
  }) {
    final doubleDividerLine = StringBuffer();
    final singleDividerLine = StringBuffer();
    for (var i=0; i<lineLength - 1; i++) {
      doubleDividerLine.write(_doubleDivider);
      singleDividerLine.write(_singleDivider);
    }

    _topBorder = '$_topLeftCorner$doubleDividerLine';
    _middleBorder = '$_middleCorner$singleDividerLine';
    _bottomBorder = '$_bottomLeftCorner$doubleDividerLine';
  }

  /// 로그를 생성한다.
  List<String> log(LogEvent event, {bool onlyShowMessage = false}) {
    final emoticon = _getEmoticonByLevel(event.level);
    final message = _stringifyMessage(event.message);

    final buffer = <String>[];
    buffer.add('$emoticon $message');

    if (!onlyShowMessage) {
      buffer.add(_topBorder);

      final error = event.error?.toString();
      if (error != null) {
        for (var line in error.split('\n'))
          buffer.add('$_verticalLine $line');
        buffer.add(_middleBorder);
      }

      String? stackTrace;
      if (event.stackTrace == null) {
        if (methodCount > 0)
          stackTrace = _formatStackTrace(StackTrace.current, methodCount);
      } else if (errorMethodCount > 0) {
        stackTrace = _formatStackTrace(event.stackTrace, errorMethodCount);
      }

      if (stackTrace != null) {
        for (var line in stackTrace.split('\n'))
          buffer.add('$_verticalLine $line');
        buffer.add(_middleBorder);
      }

      final timestamp = DateTime.now().toString();
      buffer.add('$_verticalLine $timestamp');

      final detail = _stringifyMessage(event.detail);
      if (detail != null) {
        buffer.add(_middleBorder);
        for (var line in detail.split('\n'))
          buffer.add('$_verticalLine $emoticon $line');
      }

      buffer.add(_bottomBorder);
    }

    return buffer;
  }

  String _getEmoticonByLevel(LogLevel level) {
    switch (level) {
      case LogLevel.fatal:
        return '💣';
      case LogLevel.error:
        return '⛔';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.info:
        return '💡';
      case LogLevel.debug:
        return '🐛';
    }
  }

  bool _discardDeviceStackTraceLine(String line) {
    final match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) return false;

    return match.group(2)!.startsWith('package:logger');
  }

  bool _discardWebStackTraceLine(String line) {
    final match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) return false;

    return match.group(1)!.startsWith('packages/logger') ||
        match.group(1)!.startsWith('dart-sdk/lib');
  }

  bool _discardBrowserStackTraceLine(String line) {
    final match = _browserStackTraceRegex.matchAsPrefix(line);
    if (match == null) return false;

    return match.group(1)!.startsWith('package:logger') ||
        match.group(1)!.startsWith('dart:');
  }

  String? _stringifyMessage(dynamic message) {
    if (message == null) return null;

    if (message is Map || message is Iterable) {
      final encoder = JsonEncoder.withIndent('  ', (obj) => obj.toString());
      return encoder.convert(message);
    }

    return message.toString();
  }

  String? _formatStackTrace(StackTrace? stackTrace, int methodCount) {
    var lines = stackTrace.toString().split('\n');
    if (stackTraceBeginIndex > 0 && stackTraceBeginIndex < lines.length - 1)
      lines = lines.sublist(stackTraceBeginIndex);

    var formatted = <String>[];
    var count = 0;
    for (var line in lines) {
      if (line.isEmpty ||
          _discardDeviceStackTraceLine(line) ||
          _discardWebStackTraceLine(line) ||
          _discardBrowserStackTraceLine(line))
        continue;

      formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');

      if (++count == methodCount) break;
    }

    if (formatted.isEmpty)
      return null;
    else
      return formatted.join('\n');
  }
}
