import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/shared/components/buttons/app_small_filled_button.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/shared/commons/icons/app_icons.dart';

class SwitchConcertTitle extends StatelessWidget {
  final ConcertEntity concert;
  final VoidCallback onTap;

  const SwitchConcertTitle({
    Key? key,
    required this.onTap,
    required this.concert,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppSmallFilledButton.secondary(
      onTap: onTap,
      text: '${concert.city}, ${concert.countryCode}',
      icon: AppIcons.switchConcert,
    );
  }
}
