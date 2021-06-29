import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/blocs/bloc.dart';

/// 프로그레스 상태 관리 기능이 구현된 BLoC
class ProgressBloc implements Bloc<ProgressBloc> {
  final _progressStateController = StreamController<bool>();

  /// [_progressStateController]의 [Stream]을 반환한다.
  Stream<bool> get progressStateStream => _progressStateController.stream;

  /// [_progressStateController]의 [StreamSink]를 반환한다.
  StreamSink<bool> get progressStateStreamSink => _progressStateController.sink;

  /// [function]과 함께 프로그레스를 수행한다.
  Future<void> withProgress(Future Function() function) async {
    setProgressState(true);
    await function().whenComplete(() => setProgressState(false));
  }

  /// 프로그레스 상태를 변경한다.
  void setProgressState(bool state) =>
      _progressStateController.sink.add(state);

  @override
  ProgressBloc initialize(BuildContext context) => this;
  
  @override
  void dispose() => _progressStateController.close();
}

/// 프로그레스 상태 관리 기능이 구현된 BLoC
class BroadcastProgressBloc implements Bloc<BroadcastProgressBloc> {
  final _progressStateController = StreamController<bool>.broadcast();

  /// [_progressStateController]의 [Stream]을 반환한다.
  Stream<bool> get progressStateStream => _progressStateController.stream;

  /// [_progressStateController]의 [StreamSink]를 반환한다.
  StreamSink<bool> get progressStateStreamSink => _progressStateController.sink;

  /// [function]과 함께 프로그레스를 수행한다.
  Future<void> withProgress(Future Function() function) async {
    setProgressState(true);
    await function().whenComplete(() => setProgressState(false));
  }

  /// 프로그레스 상태를 변경한다.
  void setProgressState(bool state) =>
      _progressStateController.sink.add(state);

  @override
  BroadcastProgressBloc initialize(BuildContext context) => this;

  @override
  void dispose() => _progressStateController.close();
}
