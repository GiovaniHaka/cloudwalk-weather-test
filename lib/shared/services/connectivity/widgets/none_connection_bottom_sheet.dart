import 'package:cloudwalk/shared/commons/constants/radius_constants.dart';
import 'package:cloudwalk/shared/services/connectivity/widgets/none_connection_view.dart';
import 'package:flutter/material.dart';

class NoneConnectionBottomSheet extends StatelessWidget {
  const NoneConnectionBottomSheet({super.key});

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(regularRadius),
        ),
      ),
      builder: (context) => const NoneConnectionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CloseButton(),
          ),
          NoneConnectionView(),
        ],
      ),
    );
  }
}
