import 'dart:async';

/// [AppTimerCallback] is a class that will handle the timer callback.
class AppTimerCallback {
  final Duration _duration;

  AppTimerCallback({
    Duration duration = const Duration(milliseconds: 200),
  }) : _duration = duration;

  Timer? _timer;

  setTimer(Function callback) {
    final timer = _timer;

    if (timer != null) {
      timer.cancel();
    }

    int counter = 6;
    _timer = Timer.periodic(
      _duration,
      (timer) async {
        if (counter-- == 0) {
          timer.cancel();
          callback();
        }
      },
    );
  }

  cancelTimer() {
    final timer = _timer;

    if (timer != null) {
      timer.cancel();
    }
  }
}
