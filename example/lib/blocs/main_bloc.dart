import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/flutter_dev_framework.dart';

/// 메인 페이지 BLoC
class MainBloc extends StreamBloc<MainBloc, int> {
  @override
  MainBloc initialize(BuildContext context) => this;

  /// 랜덤 값을 응답받는다.
  Future<void> fetchRandomNumber({int maxNumber = 10}) async {
    addLoadingResponse();

    final random = Random();
    await Future.delayed(Duration(seconds: random.nextInt(5)));
    addDoneResponse(random.nextInt(maxNumber) + 1);
  }
}
