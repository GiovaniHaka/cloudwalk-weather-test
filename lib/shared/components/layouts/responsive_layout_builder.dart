import 'package:flutter/material.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget? mobileChild;
  final Widget? tabletChild;
  final Widget? laptopChild;
  final Widget? largeChild;

  const ResponsiveLayoutBuilder({
    Key? key,
    this.mobileChild,
    this.tabletChild,
    this.laptopChild,
    this.largeChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mobile = 600;
    const tablets = 800;
    const laptop = 1000;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobile) {
          return mobileChild ??
              tabletChild ??
              laptopChild ??
              largeChild ??
              const SizedBox.shrink();
        }

        if (constraints.maxWidth < tablets) {
          return tabletChild ??
              mobileChild ??
              laptopChild ??
              largeChild ??
              const SizedBox.shrink();
        }

        if (constraints.maxWidth < laptop) {
          return laptopChild ??
              tabletChild ??
              mobileChild ??
              largeChild ??
              const SizedBox.shrink();
        }

        return largeChild ??
            laptopChild ??
            tabletChild ??
            mobileChild ??
            const SizedBox.shrink();
      },
    );
  }
}
