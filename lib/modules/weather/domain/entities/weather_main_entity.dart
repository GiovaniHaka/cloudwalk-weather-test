class WeatherMainEntity {
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final double humidity;

  WeatherMainEntity({
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
  });

  String get temperatureWithUnits {
    return '${temperature.toStringAsFixed(0)} °C';
  }

  String get maxTemperatureWithUnits {
    return '${maxTemperature.toStringAsFixed(0)} °C';
  }

  String get minTemperatureWithUnits {
    return '${minTemperature.toStringAsFixed(0)} °C';
  }
}
