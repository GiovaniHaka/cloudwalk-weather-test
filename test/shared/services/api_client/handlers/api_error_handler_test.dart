import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/services/api_client/handlers/api_error_handler.dart';
import 'package:flutter_test/flutter_test.dart';

class TestFailure extends Failure {}

void main() {
  group('$ApiErrorHandler mapErrorCode', () {
    test('should return defaultFailure when code is null', () {
      final failure = ApiErrorHandler.mapErrorCode(
        null,
        defaultFailure: Failure(),
      );
      expect(failure, isA<Failure>());
    });

    test('should return defaultFailure when code is not handled', () {
      final failure = ApiErrorHandler.mapErrorCode(
        '404',
        defaultFailure: Failure(),
      );
      expect(failure, isA<Failure>());
    });

    test('should return defaultFailure when code is handled', () {
      final failure = ApiErrorHandler.mapErrorCode(
        '500',
        defaultFailure: Failure(),
      );
      expect(failure, isA<Failure>());
    });

    test('should return defaultFailure when code is not handled', () {
      final failure = ApiErrorHandler.mapErrorCode(
        '404',
        defaultFailure: TestFailure(),
      );
      expect(failure, isA<TestFailure>());
    });
  });
}
