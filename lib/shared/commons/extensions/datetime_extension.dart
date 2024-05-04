import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime withoutTime() {
    return DateTime(year, month, day);
  }

  bool isAtSameDateWithourTime(DateTime other) {
    return withoutTime() == other.withoutTime();
  }

  String formatWeekday() {
    return DateFormat('EEE').format(this);
  }
}
