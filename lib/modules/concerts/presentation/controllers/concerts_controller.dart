import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/domain/usecases/get_concert_usecase.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ConcertsController {
  final GetConcertUsecase _getConcertUsecase;

  ConcertsController({
    required GetConcertUsecase getConcertUsecase,
  }) : _getConcertUsecase = getConcertUsecase;

  final _concerts = RxNotifier<AppState<List<ConcertEntity>>>(Initial());
  AppState<List<ConcertEntity>> get concerts => _concerts.value;

  initialize() {
    _getConcerts();
  }

  Future<void> _getConcerts() async {
    try {
      _concerts.value = Loading();
      final result = await _getConcertUsecase.call();

      result.fold(
        (failure) => _concerts.value = Error(failure),
        (concerts) {
          if (concerts.isEmpty) {
            return _concerts.value = Empty();
          }
          
          return _concerts.value = Loaded(concerts);
        },
      );
    } catch (e, s) {
      _concerts.value = Error(Failure(error: e, stackTrace: s));
    }
  }
}
