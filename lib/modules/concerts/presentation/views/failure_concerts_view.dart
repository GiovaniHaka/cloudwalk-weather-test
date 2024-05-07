import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/buttons/app_text_button.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [FailureConcertsView] is a view that shows when there is a failure to get concerts
class FailureConcertsView extends StatelessWidget {
  final Failure failure;
  final VoidCallback onTapTryAgain;

  const FailureConcertsView({
    Key? key,
    required this.failure,
    required this.onTapTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(viewPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            failure.message,
            style: AppTextStyle.bodyLarge(),
          ),
          AppTextButton.primary(
            text: Language.instance.lang.buttonTryAgain,
            onTap: onTapTryAgain,
          )
        ],
      ),
    );
  }
}
