import 'dart:convert';
import 'package:flutter_dev_framework/logger/logger.dart';
import 'package:flutter_dev_framework/network/exception/api_exception.dart';
import 'package:flutter_dev_framework/network/model/charset.dart';
import 'package:flutter_dev_framework/network/model/http_media_type.dart';
import 'package:flutter_dev_framework/network/model/http_request_method.dart';
import 'package:flutter_dev_framework/network/model/network_protocol.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

/// REST API 구현에 필요한 기능을 제공하는 추상 클래스
abstract class RestApi {
  NetworkProtocol? _networkProtocol;
  NetworkProtocol? get networkProtocol => _networkProtocol;

  String? _authority;
  String? get authority => _authority;

  Map<String, String>? _headers;
  Map<String, String>? get headers => _headers;

  Duration? _timeout;
  Duration? get timeout => _timeout;

  /// API 클래스를 초기화한다.
  void initialize({
    required String authority,
    Map<String, String>? headers,
    HttpMediaType accept = HttpMediaType.APPLICATION_JSON,
    HttpMediaType contentType = HttpMediaType.APPLICATION_JSON,
    Charset charset = Charset.UTF_8,
    Duration timeout = const Duration(seconds: 10)
  }) {
    final splitAuthority = authority.split('://');
    if (splitAuthority.length == 2) {
      if (splitAuthority.first.toLowerCase() == 'http')
        _networkProtocol = NetworkProtocol.HTTP;
      else if (splitAuthority.first.toLowerCase() == 'https')
        _networkProtocol = NetworkProtocol.HTTPS;
      else
        throw ApiException('정의되지 않은 네트워크 프로토콜입니다.');
    } else if (splitAuthority.length == 1) {
      _networkProtocol = NetworkProtocol.HTTPS;
    } else {
      throw ApiException('주소 형태가 올바르지 않습니다.');
    }

    _authority = splitAuthority.last;

    final acString = getStringByHttpMediaType(accept);
    final ctString = getStringByHttpMediaType(contentType);
    final csString = getStringByCharset(charset);
    _headers = Map<String, String>();
    _headers!['Accept'] = '$acString';
    _headers!['Content-Type'] = '$ctString; charset=$csString';
    headers?.forEach((k, v) => _headers![k] = v);

    _timeout = timeout;
  }

  /// [reqMethod]를 사용하여 [path]에 REST API 요청한다.
  Future<Map<String, dynamic>> rest({
    required HttpRequestMethod reqMethod,
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic body
  }) async {
    if (_authority == null)
      throw ApiException('API 클래스가 초기화되지 않았습니다.');

    final completedUri = (_networkProtocol == NetworkProtocol.HTTP)
        ? Uri.http(_authority!, path, queryParameters)
        : Uri.https(_authority!, path, queryParameters);
    Response response;

    switch (reqMethod) {
      case HttpRequestMethod.GET:
        response = await get(completedUri, headers: _headers)
            .timeout(_timeout!);
        break;
      case HttpRequestMethod.PUT:
        response = await put(completedUri, headers: _headers,
            body: json.encode(body)).timeout(_timeout!);
        break;
      case HttpRequestMethod.POST:
        response = await post(completedUri, headers: _headers,
            body: json.encode(body)).timeout(_timeout!);
        break;
      case HttpRequestMethod.DELETE:
        response = await delete(completedUri, headers: _headers)
            .timeout(_timeout!);
    }

    if (!kReleaseMode) {
      final sb = StringBuffer();
      sb.write('\n');
      sb.write('====== [REST API RESULT] ======\n');
      sb.write('protocol: $_networkProtocol\n');
      sb.write('method:   $reqMethod\n');
      sb.write('uri:      $_authority$path\n');
      sb.write('headers:  $_headers\n');
      sb.write('body:     $body\n');
      sb.write('result(${response.statusCode}): ${getDecodedBody(response)}\n');
      sb.write('===============================\n');
      Logger.i(sb.toString());
    }

    return checkStatusCode(response);
  }

  /// Process the response according to the status code.
  Future<Map<String, dynamic>> checkStatusCode(Response response) {
    final decodedBody = getDecodedBody(response);
    String? resultMessage =
        decodedBody['resultMessage']
            ?? decodedBody['result_message'];

    switch (response.statusCode) {
      case 200: // OK
        return Future.value(decodedBody);
      case 400: // Bad Request
        throw ApiException(resultMessage ?? '잘못된 요청입니다.');
      case 401: // Unauthorized
        throw ApiException(resultMessage ?? '인증에 실패하여 요청을 처리할 수 없습니다.');
      case 403: // Forbidden
        throw ApiException(resultMessage ?? '접근 권한이 없어 요청이 거부되었습니다.');
      case 404: // Not Found
        throw ApiException(resultMessage ?? '요청 리소스 또는 주소를 찾을 수 없습니다.');
      default:  // Internal Server Error
        throw ApiException('내부 서버 오류가 발생하여 요청을 처리할 수 없습니다.');
    }
  }

  /// UTF_8, JSON 디코드 된 [response] 바디를 반환한다.
  dynamic getDecodedBody(Response response) =>
      json.decode(utf8.decode(response.bodyBytes));
}
