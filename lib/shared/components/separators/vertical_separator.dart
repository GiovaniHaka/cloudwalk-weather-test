import 'package:flutter/material.dart';

class VerticalSeparator extends StatelessWidget {
  final double height;

  const VerticalSeparator({
    super.key,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }

  const VerticalSeparator.large({
    super.key,
    this.height = 48,
  });

  const VerticalSeparator.medium({
    super.key,
    this.height = 32,
  });

  const VerticalSeparator.regular({
    super.key,
    this.height = 24,
  });

  const VerticalSeparator.small({
    super.key,
    this.height = 16,
  });

  const VerticalSeparator.verySmall({
    super.key,
    this.height = 8,
  });

  const VerticalSeparator.text({
    super.key,
    this.height = 4,
  });

  const VerticalSeparator.zero({
    super.key,
    this.height = 1,
  });
}
