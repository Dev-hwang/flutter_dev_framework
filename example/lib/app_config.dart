import 'package:flutter/material.dart';

/// 앱 설정
class AppConfig {
  final BuildType buildType;
  final ThemeData themeData;

  AppConfig({
    required this.buildType,
    required this.themeData
  });
}

/// 빌드 타입
enum BuildType {
  DEVELOP,
  INHOUSE,
  RELEASE
}
