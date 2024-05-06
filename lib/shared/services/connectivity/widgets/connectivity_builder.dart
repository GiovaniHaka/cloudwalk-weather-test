import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/icons/app_icons.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/separators/vertical_separator.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';
import 'package:cloudwalk/shared/services/connectivity/states/connectivity_states.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
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
        return offlineChild ?? Padding(
          padding: const EdgeInsets.all(viewPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                AppIcons.noneConnection,
                size: 30,
              ),
              const VerticalSeparator.small(),
              Text(
                Language.instance.lang.noneConnection,
                style: AppTextStyle.titleLarge(),
                textAlign: TextAlign.center,
              ),
              const VerticalSeparator.small(),
              Text(
                Language.instance.lang.verifyYourConnection,
                style: AppTextStyle.bodyLarge(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
      return onlineChild ?? const SizedBox.shrink();
    });
  }
}
