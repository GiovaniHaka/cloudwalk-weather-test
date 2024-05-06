import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/commons/icons/app_icons.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';
import 'package:cloudwalk/shared/services/connectivity/states/connectivity_states.dart';
import 'package:cloudwalk/shared/services/connectivity/widgets/none_connection_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

/// [ConnectivityStatusIcon] is a widget that will show an icon when the user has no connection.
class ConnectivityStatusIcon extends StatelessWidget {
  const ConnectivityStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityService = getIt.get<ConnectivityService>();

    handleShowConnectionDetails() {
      const NoneConnectionBottomSheet().show(context);
    }

    return RxBuilder(builder: (_) {
      final connectionState = connectivityService.state;

      if (connectionState is NoneConnection) {
        return IconButton(
          onPressed: handleShowConnectionDetails,
          icon: const Icon(
            AppIcons.noneConnection,
            size: 20,
          ),
        );
      }

      return const SizedBox.shrink();
    });
  }
}
