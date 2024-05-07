import 'package:cloudwalk/modules/concerts/domain/usecases/get_concert_usecase.dart';
import 'package:cloudwalk/shared/commons/extensions/either_extensions.dart';
import 'package:cloudwalk/shared/commons/failures/domain_failures/usecase_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../concert_domain_mocks.dart';

void main() {
  late GetConcertUsecase usecase;
  late MockConcertRepository mockRepository;

  setUp(() {
    mockRepository = MockConcertRepository();
    usecase = GetConcertUsecaseImpl(repository: mockRepository);
  });

  group('$GetConcertUsecase', () {
    const searchCity = 'New York';

    test('should return a list of ConcertEntity on success', () async {
      // Arrange
      final concerts = [
        MockConcertEntity(),
        MockConcertEntity(),
      ];

      when(
        () => mockRepository.getConcerts(searchCity: searchCity),
      ).thenAnswer((_) async => Right(concerts));

      // Act
      final result = await usecase.call(searchCity: searchCity);

      // Assert
      expect(result, Right(concerts));

      verify(
        () => mockRepository.getConcerts(searchCity: searchCity),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a UsecaseFailure on repository failure', () async {
      final failure = UsecaseFailure();

      when(
        () => mockRepository.getConcerts(searchCity: searchCity),
      ).thenAnswer((_) async => Left(failure));

      final result = await usecase.call(searchCity: searchCity);

      expect(result, Left(failure));

      verify(
        () => mockRepository.getConcerts(searchCity: searchCity),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a UsecaseFailure on exception', () async {
      // Arrange
      final exception = Exception();

      when(
        () => mockRepository.getConcerts(searchCity: searchCity),
      ).thenThrow(exception);

      // Act
      final result = await usecase.call(searchCity: searchCity);

      // Assert
      expect(result.toLeft(), isA<UsecaseFailure>());

      verify(
        () => mockRepository.getConcerts(searchCity: searchCity),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });
  });
}
