import 'package:flutter/material.dart';

class LoadingCurrentWeatherView extends StatelessWidget {
  const LoadingCurrentWeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
