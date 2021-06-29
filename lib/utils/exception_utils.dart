import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_dev_framework/network/exception/api_exception.dart';
import 'package:flutter_dev_framework/utils/date_time_utils.dart';
import 'package:flutter_dev_framework/utils/file_manage_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// 예외 처리 유틸리티
class ExceptionUtils {
  ExceptionUtils._internal();
  static final instance = ExceptionUtils._internal();

  /// [exception]이 발생한 이유를 문자열로 반환한다.
  /// 정의된 조건 이외의 예외가 발생하면 [unknownIssueMsg]를 반환한다.
  /// 발생된 예외를 로그 파일로 남기려면 [writeLog]를 `true`로 설정해야 한다.
  String getReasonByException(dynamic exception, {
    String unknownIssueMsg = '',
    bool writeLog = false
  }) {
    if (exception is SocketException)
      unknownIssueMsg = '네트워크 연결 상태가 좋지 않습니다.';
    else if (exception is TimeoutException)
      unknownIssueMsg = '서버와의 통신이 원활하지 않습니다.';
    else if (exception is DatabaseException)
      unknownIssueMsg = '데이터 저장 중 오류가 발생했습니다.';
    else if (exception is FormatException)
      unknownIssueMsg = '유효하지 않은 데이터 형식입니다.';
    else if (exception is ApiException)
      unknownIssueMsg = exception.toString();
    else if (unknownIssueMsg.isEmpty)
      unknownIssueMsg = '오류가 발생하여 요청을 수행할 수 없습니다.';

    if (writeLog) {
      Future.microtask(() async {
        final directory = await getExternalStorageDirectory();
        if (directory == null) return;

        final nowDate = DateTimeUtils.instance.getNowDateString();
        final nowTime = DateTimeUtils.instance.getNowTimeString();

        FileManageUtils.instance.writeTextFile(
          filePath: '${directory.absolute.path}/${nowDate}_exception_log.txt',
          text: '$nowTime $exception'
        );
      });
    }

    if (!kReleaseMode)
      unknownIssueMsg += '\nException >> $exception';

    return unknownIssueMsg;
  }
}
