import 'package:cloudwalk/modules/concerts/data/mappers/concert_mapper.dart';
import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/modules/concerts/data/sources/local/local_concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/remote/remote_concert_source.dart';
import 'package:mocktail/mocktail.dart';

/// Sources
class MockRemoteConcertSource extends Mock implements RemoteConcertSource {}

class MockLocalConcertSource extends Mock implements LocalConcertSource {}

/// Mappers
class MockConcertMapper extends Mock implements ConcertMapper {}

/// Models
class MockConcertModel extends Mock implements ConcertModel {}

