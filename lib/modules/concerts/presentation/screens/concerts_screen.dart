import 'package:cloudwalk/modules/concerts/presentation/views/empty_concerts_view.dart';
import 'package:cloudwalk/modules/concerts/presentation/views/failure_concerts_view.dart';
import 'package:cloudwalk/modules/concerts/presentation/views/loaded_concerts_view.dart';
import 'package:cloudwalk/modules/concerts/presentation/views/loading_concerts_view.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/modules/concerts/presentation/controllers/concerts_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ConcertsScreen extends StatefulWidget {
  final ConcertsController concertsController;

  const ConcertsScreen({
    Key? key,
    required this.concertsController,
  }) : super(key: key);

  @override
  State<ConcertsScreen> createState() => _ConcertsScreenState();
}

class _ConcertsScreenState extends State<ConcertsScreen> {
  late ConcertsController _concertsController;

  @override
  void initState() {
    super.initState();
    _concertsController = widget.concertsController;

    _concertsController.initialize();
  }

  handleTryAgain() {
    _concertsController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RxBuilder(
        builder: (_) {
          final concertsState = _concertsController.concerts;

          if (concertsState is Error) {
            final failure = concertsState.failure;
            return FailureConcertsView(
              failure: failure,
              onTapTryAgain: handleTryAgain,
            );
          }

          if (concertsState is Empty) {
            return const EmptyConcertsView();
          }

          if (concertsState is Loaded) {
            final concerts = concertsState.data;
            return LoadedConcertsView(
              concerts: concerts,
              onTapConcert: (val) {},
            );
          }

          return const LoadingConcertsView();
        },
      ),
    );
  }
}
