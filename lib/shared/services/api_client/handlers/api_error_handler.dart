import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [ApiErrorHandler] class is responsible for handling API errors.
/// This class can be extended to handle different error codes from different APIs.
class ApiErrorHandler {
  static Failure mapErrorCode(
    String? code, {
    Failure? defaultFailure,
  }) {
    return Failure();
  }
}
