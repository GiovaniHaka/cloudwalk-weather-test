import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/domain/repositories/concert_repository.dart';
import 'package:cloudwalk/modules/concerts/domain/usecases/get_concert_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Entities
class MockConcertEntity extends Mock implements ConcertEntity {}

// Repositories
class MockConcertRepository extends Mock implements ConcertRepository {}

// Usecases
class MockGetConcertUsecase extends Mock implements GetConcertUsecase {}
