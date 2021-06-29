import 'package:flutter/material.dart';

/// BLoC 구현에 필요한 함수를 제공하는 추상 클래스
abstract class Bloc<T> {
  /// [context]와 함께 BLoC 내부 리소스를 초기화한다.
  T initialize(BuildContext context);

  /// BLoC 내부 리소스를 정리한다.
  void dispose();
}
