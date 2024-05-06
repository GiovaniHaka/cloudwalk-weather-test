import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/modules/concerts/data/sources/mock_remote_source/remote_concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/mock_data/mock_concert_data.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/source_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [MockRemoteConcertSourceImpl] is a mock source that implements [RemoteConcertSource]
class MockRemoteConcertSourceImpl extends RemoteConcertSource {
  @override
  Future<Either<Failure, List<ConcertModel>>> getConcerts({
    String? searchCity,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      const data = mockConcertData;

      List<ConcertModel> models = data.map((e) {
        return ConcertModel.fromJson(e);
      }).toList();

      if (searchCity != null) {
        models = models.where((element) {
          final city = element.city.toLowerCase();
          return city.contains(searchCity.toLowerCase());
        }).toList();
      }

      return Right(models);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }
}
