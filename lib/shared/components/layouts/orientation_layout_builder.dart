import 'package:flutter/material.dart';

/// [OrientationLayoutBuilder] is a widget that builds a layout based on the orientation.
class OrientationLayoutBuilder extends StatelessWidget {
  final Widget verticalChild;
  final Widget horizontalChild;

  const OrientationLayoutBuilder({
    Key? key,
    required this.verticalChild,
    required this.horizontalChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return verticalChild;
        }

        return horizontalChild;
      },
    );
  }
}
