import 'package:flutter/material.dart';

/// [HorizontalSeparator] is a widget that creates a horizontal separator.
class HorizontalSeparator extends StatelessWidget {
  final double width;

  const HorizontalSeparator({
    super.key,
    this.width = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }

  const HorizontalSeparator.large({
    super.key,
    this.width = 48,
  });

  const HorizontalSeparator.medium({
    super.key,
    this.width = 30,
  });

  const HorizontalSeparator.regular({
    super.key,
    this.width = 24,
  });

  const HorizontalSeparator.small({
    super.key,
    this.width = 16,
  });

  const HorizontalSeparator.verySmall({
    super.key,
    this.width = 8,
  });
}
