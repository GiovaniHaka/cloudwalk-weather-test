import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/icons/app_icons.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/separators/vertical_separator.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/widgets.dart';

/// [NoneConnectionView] is a widget that will show a message when the user has no connection.
class NoneConnectionView extends StatelessWidget {
  const NoneConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
}
