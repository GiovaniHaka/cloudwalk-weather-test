import 'package:flutter/material.dart';

/// [LoadingCurrentWeatherView] is a view that displays a loading indicator.
class LoadingCurrentWeatherView extends StatelessWidget {
  const LoadingCurrentWeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
