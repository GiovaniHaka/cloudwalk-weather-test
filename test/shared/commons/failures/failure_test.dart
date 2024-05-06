import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$Failure', () {
    test('message should be initialized correctly', () {
      final failure = Failure(message: 'Test Message');

      expect(failure.message, 'Test Message');
    });

    test('error should be initialized correctly', () {
      final error = Exception('Test Error');
      final failure = Failure(error: error);

      expect(failure.error, error);
    });

    test('stackTrace should be initialized correctly', () {
      final stackTrace = StackTrace.current;
      final failure = Failure(stackTrace: stackTrace);

      expect(failure.stackTrace, stackTrace);
    });

    test('message should fallback to default if not provided', () {
      final failure = Failure();

      expect(failure.message, isNotNull);
    });
  });
}
