import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/presentation/controllers/concerts_controller.dart';
import 'package:cloudwalk/modules/concerts/presentation/views/empty_concerts_view.dart';
import 'package:cloudwalk/modules/concerts/presentation/views/failure_concerts_view.dart';
import 'package:cloudwalk/modules/concerts/presentation/views/loaded_concerts_view.dart';
import 'package:cloudwalk/modules/concerts/presentation/views/loading_concerts_view.dart';
import 'package:cloudwalk/modules/weather/presentation/controllers/current_weather_controller.dart';
import 'package:cloudwalk/shared/commons/app_bar/app_top_bar.dart';
import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/forms/app_text_form_field.dart';
import 'package:cloudwalk/shared/components/forms/app_unfocuser.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';

/// [ConcertsScreen] is a screen that shows the concerts and allows the user to search for concerts.
class ConcertsScreen extends StatefulWidget {
  final ConcertsController concertsController;
  final CurrentWeatherController currentWeatherController;

  const ConcertsScreen({
    Key? key,
    required this.concertsController,
    required this.currentWeatherController,
  }) : super(key: key);

  @override
  State<ConcertsScreen> createState() => _ConcertsScreenState();
}

class _ConcertsScreenState extends State<ConcertsScreen> {
  late ConcertsController _concertsController;
  late CurrentWeatherController _currentWeatherController;

  @override
  void initState() {
    super.initState();
    _concertsController = widget.concertsController;
    _currentWeatherController = widget.currentWeatherController;

    _concertsController.initialize();
  }

  /// Callback function to handle the change in the search city name.
  onChangeSearchCityName(String? name) {
    _concertsController.onChangeSearchCityName(name);
  }

  /// Callback function to handle the selection of a concert.
  handleConcert(ConcertEntity value) {
    _currentWeatherController.onChangeConcert(value);
    Navigator.pop(context);
  }

  /// Callback function to handle the "Try Again" action.
  handleTryAgain() {
    _concertsController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return AppUnfocuser(
      child: Scaffold(
        appBar: AppTopBar(
          title: Text(
            Language.instance.lang.concerts,
            style: AppTextStyle.titleMedium(),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(viewPadding),
                child: AppTextFormField(
                  onChanged: onChangeSearchCityName,
                  hintText: Language.instance.lang.hintSearchCity,
                ),
              ),
              Expanded(
                child: RxBuilder(
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
                        onTapConcert: handleConcert,
                      );
                    }

                    return const LoadingConcertsView();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
