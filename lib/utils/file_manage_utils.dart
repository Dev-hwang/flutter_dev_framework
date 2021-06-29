import 'dart:io';
import 'package:flutter_dev_framework/logger/logger.dart';

/// 파일 관리 유틸리티
class FileManageUtils {
  FileManageUtils._internal();
  static final instance = FileManageUtils._internal();

  /// [filePath] 텍스트 파일을 생성한다.
  Future<String> writeTextFile({required String filePath, required String text}) async {
    try {
      final textBuffer = StringBuffer();
      final textFile = File(filePath);
      
      if (await textFile.exists())
        textBuffer.write('${await textFile.readAsString()}\r\n');
      textBuffer.write(text);
      
      await textFile.writeAsString(textBuffer.toString());
      return Future.value(textFile.path);
    } catch (error, stackTrace) {
      Logger.e('writeTextFile()', error: error, stackTrace: stackTrace);
      return Future.value(null);
    }
  }

  /// [filePath] 텍스트 파일을 삭제한다.
  Future<bool> deleteTextFile({required String filePath}) async {
    try {
      await File(filePath).delete();
      return Future.value(true);
    } catch (error, stackTrace) {
      Logger.e('deleteTextFile()', error: error, stackTrace: stackTrace);
      return Future.value(false);
    }
  }
}
