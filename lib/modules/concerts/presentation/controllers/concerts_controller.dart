import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/domain/usecases/get_concert_usecase.dart';
import 'package:cloudwalk/shared/commons/failures/presentation_failures/controller_failure.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:cloudwalk/shared/commons/timers/app_timer_callback.dart';
import 'package:rx_notifier/rx_notifier.dart';

/// [ConcertsController] is a controller that manages the state of the concerts screen.
class ConcertsController {
  final GetConcertUsecase _getConcertUsecase;
  final AppTimerCallback _timeCall;

  ConcertsController({
    required GetConcertUsecase getConcertUsecase,
    required AppTimerCallback? timerCall,
  }) : _getConcertUsecase = getConcertUsecase,
        _timeCall = timerCall ?? AppTimerCallback(
          duration: const Duration(milliseconds: 200),
        );

  final _concerts = RxNotifier<AppState<List<ConcertEntity>>>(Initial());

  /// The current state of the concerts.
  AppState<List<ConcertEntity>> get concerts => _concerts.value;

  /// Initializes the controller by fetching the concerts.
  void initialize() {
    getConcerts();
  }

  /// Handles the change in the search city name and triggers the concert search.
  Future<void> onChangeSearchCityName(String? name) async {
    final isEmpty = name?.isEmpty ?? true;

    if (isEmpty) {
      _timeCall.cancelTimer();
      _concerts.value = Loading();
      await getConcerts();
    } else {
      _concerts.value = Loading();
      _timeCall.setTimer(() => getConcerts(searchCity: name));
    }
  }

  /// Fetches the concerts based on the provided search city.
  Future<void> getConcerts({
    String? searchCity,
  }) async {
    try {
      _concerts.value = Loading();

      final result = await _getConcertUsecase.call(
        searchCity: searchCity,
      );

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
      _concerts.value = Error(ControllerFailure(error: e, stackTrace: s));
    }
  }
}
