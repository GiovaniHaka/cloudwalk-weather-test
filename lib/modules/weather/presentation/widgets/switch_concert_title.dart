import 'package:cloudwalk/shared/components/separators/horizontal_separator.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/shared/commons/icons/app_icons.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';

class SwitchConcertTitle extends StatelessWidget {
  final VoidCallback onTap;

  const SwitchConcertTitle({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Language.instance.lang.concert,
            style: AppTextStyle.titleSmall(),
          ),
          const HorizontalSeparator.verySmall(),
          const Icon(
            AppIcons.switchConcert,
            size: 20,
          )
        ],
      ),
    );
  }
}
