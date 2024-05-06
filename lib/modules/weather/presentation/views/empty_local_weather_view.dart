import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/separators/vertical_separator.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/material.dart';

class EmptyLocalWeatherView extends StatelessWidget {
  const EmptyLocalWeatherView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(viewPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '--',
              style: AppTextStyle.headlineLarge(),
            ),
            const VerticalSeparator.regular(),
            Text(
              Language.instance.lang.noLocalWeatherData,
              style: AppTextStyle.bodyLarge(),
              textAlign: TextAlign.center,
            ),
            const VerticalSeparator.text(),
            Text(
              Language.instance.lang.connectToInternetAndTryAgain,
              style: AppTextStyle.bodyLarge(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
