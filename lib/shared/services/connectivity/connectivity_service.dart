import 'dart:async';
import 'package:cloudwalk/shared/services/connectivity/states/connectivity_states.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rx_notifier/rx_notifier.dart';

/// [ConnectivityService] is a class that will handle the connectivity state of the app.
class ConnectivityService {
  ConnectivityService() {
    initialize();
  }

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final _state = RxNotifier<ConnectivityState>(NoneConnection());
  ConnectivityState get state => _state.value;

  initialize() {
    final connectivity = Connectivity();

    _connectivitySubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult.contains(ConnectivityResult.mobile)) {
          _state.value = MobileConnection();
          return;
        }

        if (connectivityResult.contains(ConnectivityResult.wifi)) {
          _state.value = WifiConnection();
          return;
        }

        _state.value = NoneConnection();
      },
    );
  }

  dispose() {
    _connectivitySubscription?.cancel();
  }
}
