import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/presentation/controllers/concerts_controller.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared/commons/commons_mocks.dart';
import '../../domain/concert_domain_mocks.dart';

void main() {
  late ConcertsController concertsController;
  late MockGetConcertUsecase mockGetConcertUsecase;
  late MockAppTimerCallback mockAppTimerCallback;

  setUp(() {
    mockGetConcertUsecase = MockGetConcertUsecase();
    mockAppTimerCallback = MockAppTimerCallback();

    concertsController = ConcertsController(
      getConcertUsecase: mockGetConcertUsecase,
      timerCall: mockAppTimerCallback,
    );
  });

  group('$ConcertsController initialize', () {
    test('initialize should call getConcerts', () {
      concertsController.initialize();

      verify(() => mockGetConcertUsecase.call()).called(1);
    });
  });

  group('$ConcertsController getConcerts', () {
    test('should set concerts on success', () async {
      // Arrange
      final concerts = [
        MockConcertEntity(),
        MockConcertEntity(),
      ];

      when(
        () => mockGetConcertUsecase.call(),
      ).thenAnswer((_) async => Right(concerts));

      // Act
      await concertsController.getConcerts();

      // Assert
      expect(concertsController.concerts, isA<Loaded<List<ConcertEntity>>>());
    });

    test('should set failure on failure', () async {
      // Arrange
      final failure = Failure(message: 'Test Message');

      when(
        () => mockGetConcertUsecase.call(),
      ).thenAnswer((_) async => Left(failure));

      // Act
      await concertsController.getConcerts();

      // Assert
      expect(concertsController.concerts, isA<Error<List<ConcertEntity>>>());
    });

    test('should set Empty on empty concerts', () async {
      // Arrange
      final concerts = <ConcertEntity>[];

      when(
        () => mockGetConcertUsecase.call(),
      ).thenAnswer((_) async => Right(concerts));

      // Act
      await concertsController.getConcerts();

      // Assert
      expect(concertsController.concerts, isA<Empty<List<ConcertEntity>>>());
    });

    test('should set failure on exception', () async {
      // Arrange
      final exception = Exception();

      when(
        () => mockGetConcertUsecase.call(),
      ).thenThrow(exception);

      // Act
      await concertsController.getConcerts();

      // Assert
      expect(concertsController.concerts, isA<Error<List<ConcertEntity>>>());
    });
  });
}
