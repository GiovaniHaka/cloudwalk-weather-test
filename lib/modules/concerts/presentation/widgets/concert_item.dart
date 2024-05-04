import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(viewPadding),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  concert.city,
                  style: AppTextStyle.titleLarge(),
                ),
              ),
              Text(
                concert.countryCode,
                style: AppTextStyle.titleMedium(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
