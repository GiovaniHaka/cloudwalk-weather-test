/// [ApiException] is a custom exception class that is thrown when an error occurs during API calls.
class ApiException implements Exception {
  final String? errorCode;
  final int? code;

  ApiException({
    this.errorCode,
    this.code,
  });

  @override
  String toString() {
    return 'ApiException{message: $errorCode, code: $code}';
  }
}
