import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/modules/concerts/data/sources/concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/mock/mock_concert_data.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/source_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [MockConcertSourceImpl] is a mock source that implements [ConcertSource]
class MockConcertSourceImpl extends ConcertSource {
  @override
  Future<Either<Failure, List<ConcertModel>>> getConcerts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      const data = mockConcertData;

      final models = data.map((e) => ConcertModel.fromJson(e)).toList();

      return Right(models);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }
}
