import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/icons/app_icons.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/buttons/app_small_filled_button.dart';
import 'package:cloudwalk/shared/components/separators/vertical_separator.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/material.dart';

/// [EmptyConcertWeatherView] is a view that shows when there is no concert selected.
class EmptyConcertWeatherView extends StatelessWidget {
  final VoidCallback onTapChooseConcert;

  const EmptyConcertWeatherView({
    super.key,
    required this.onTapChooseConcert,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(viewPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Language.instance.lang.welcomeToCloudwalkWeather,
            style: AppTextStyle.headlineMedium(),
            textAlign: TextAlign.center,
          ),
          const VerticalSeparator.small(),
          Text(
            Language.instance.lang.toGetStartedChooseConcert,
            style: AppTextStyle.bodyLarge(),
            textAlign: TextAlign.center,
          ),
          const VerticalSeparator.small(),
          Center(
            child: AppSmallFilledButton.primary(
              onTap: onTapChooseConcert,
              text: Language.instance.lang.buttonChoose,
              icon: AppIcons.arrowOutward,
            ),
          )
        ],
      ),
    );
  }
}
