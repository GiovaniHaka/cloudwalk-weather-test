import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/material.dart';

/// [EmptyConcertsView] is a view that shows when there are no current concerts found.
class EmptyConcertsView extends StatelessWidget {
  const EmptyConcertsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(viewPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Language.instance.lang.emptyConcerts,
            style: AppTextStyle.bodyLarge(),
          ),
        ],
      ),
    );
  }
}
