import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';
import 'package:cloudwalk/shared/services/connectivity/states/connectivity_states.dart';
import 'package:cloudwalk/shared/services/connectivity/widgets/none_connection_view.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

/// [ConnectivityBuilder] is a widget that will show a message when the user has no connection.
class ConnectivityBuilder extends StatelessWidget {
  final Widget? onlineChild;
  final Widget? offlineChild;

  const ConnectivityBuilder({
    Key? key,
    required this.onlineChild,
    required this.offlineChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connecitivityService = getIt.get<ConnectivityService>();

    return RxBuilder(builder: (_) {
      final state = connecitivityService.state;

      if (state is NoneConnection) {
        return offlineChild ?? const NoneConnectionView();
      }
      return onlineChild ?? const SizedBox.shrink();
    });
  }
}
