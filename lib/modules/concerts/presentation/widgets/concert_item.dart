import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/constants/radius_constants.dart';
import 'package:cloudwalk/shared/commons/icons/app_icons.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/separators/horizontal_separator.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';

class ConcertItem extends StatelessWidget {
  final ConcertEntity concert;
  final VoidCallback onTap;

  const ConcertItem({
    Key? key,
    required this.concert,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(regularRadius),
      child: Padding(
        padding: const EdgeInsets.all(viewPadding),
        child: Row(
          children: [
            const Icon(
              AppIcons.locationPin,
              size: 20,
            ),
            const HorizontalSeparator.small(),
            Expanded(
              child: Text(
                concert.city,
                style: AppTextStyle.titleMedium(),
              ),
            ),
            const HorizontalSeparator.small(),
            Text(
              concert.countryCode,
              style: AppTextStyle.titleMedium(),
            ),
          ],
        ),
      ),
    );
  }
}
