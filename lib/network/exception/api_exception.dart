/// API 예외
class ApiException implements Exception {
  final String? _message;

  ApiException([this._message]);

  String toString() => _message ?? 'ApiException';
}
