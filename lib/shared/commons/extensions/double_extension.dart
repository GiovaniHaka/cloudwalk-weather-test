/// [DoubleExtension] is an extension class for double data type.
extension DoubleExtension on double {
  String toTemperature([String unit = '°C']) {
    return '${toStringAsFixed(0)}$unit';
  }
}
