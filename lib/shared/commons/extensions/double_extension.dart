extension DoubleExtension on double {
  String toTemperature([String unit = '°C']) {
    return '${toStringAsFixed(0)}$unit';
  }
}
