import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/blocs/bloc.dart';

/// 스트림 응답 상태
enum StreamResponseState {
  /// 초기화 상태
  none,

  /// 로딩 상태
  loading,

  /// 완료 상태
  done,

  /// 에러 상태
  error
}

/// 스트림 응답
class StreamResponse<T> {
  final StreamResponseState state;
  final dynamic err;
  final dynamic stackTrace;
  final T? data;

  const StreamResponse(this.state, {this.err, this.stackTrace, this.data});

  static StreamResponse<T> none<T>() =>
      StreamResponse<T>(StreamResponseState.none);

  static StreamResponse<T> loading<T>() =>
      StreamResponse<T>(StreamResponseState.loading);

  static StreamResponse<T> done<T>(T? data) =>
      StreamResponse<T>(StreamResponseState.done, data: data);

  static StreamResponse<T> error<T>(error, {stackTrace}) =>
      StreamResponse<T>(StreamResponseState.error, err: error, stackTrace: stackTrace);
}

/// 스트림 처리 기능이 구현된 BLoC
abstract class StreamBloc<B, T> implements Bloc<B> {
  final _dataController = StreamController<StreamResponse<T>>();
  Stream<StreamResponse<T>> get dataStream => _dataController.stream;
  StreamSink<StreamResponse<T>> get dataStreamSink => _dataController.sink;

  StreamResponse<T> _response = StreamResponse.none();
  StreamResponse<T> get response => _response;

  /// [dataStreamSink]에 로딩 응답 이벤트를 추가한다.
  void addLoadingResponse() {
    _response = StreamResponse.loading<T>();
    dataStreamSink.add(_response);
  }

  /// [dataStreamSink]에 완료 응답 이벤트를 추가한다.
  void addDoneResponse(T? data) {
    _response = StreamResponse.done<T>(data);
    dataStreamSink.add(_response);
  }

  /// [dataStreamSink]에 에러 응답 이벤트를 추가한다.
  void addErrorResponse(error, {stackTrace}) {
    _response = StreamResponse.error<T>(error);
    dataStreamSink.add(_response);
  }

  @override
  B initialize(BuildContext context);

  @override
  void dispose() => _dataController.close();
}

/// 스트림 처리 기능이 구현된 BLoC
abstract class BroadcastStreamBloc<B, T> implements Bloc<B> {
  final _dataController = StreamController<StreamResponse<T>>.broadcast();
  Stream<StreamResponse<T>> get dataStream => _dataController.stream;
  StreamSink<StreamResponse<T>> get dataStreamSink => _dataController.sink;

  StreamResponse<T> _response = StreamResponse.none();
  StreamResponse<T> get response => _response;

  /// [dataStreamSink]에 로딩 응답 이벤트를 추가한다.
  void addLoadingResponse() {
    _response = StreamResponse.loading<T>();
    dataStreamSink.add(_response);
  }

  /// [dataStreamSink]에 완료 응답 이벤트를 추가한다.
  void addDoneResponse(T? data) {
    _response = StreamResponse.done<T>(data);
    dataStreamSink.add(_response);
  }

  /// [dataStreamSink]에 에러 응답 이벤트를 추가한다.
  void addErrorResponse(error, {stackTrace}) {
    _response = StreamResponse.error<T>(error);
    dataStreamSink.add(_response);
  }

  @override
  B initialize(BuildContext context);

  @override
  void dispose() => _dataController.close();
}
