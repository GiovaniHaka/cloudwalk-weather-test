import 'package:intl/intl.dart';

/// [DateTimeExtension] is an extension that provides additional functionality to the [DateTime] class.
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

  String formatDDMMYYYYHHmm() {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }

  String formatDDMMYYYY() {
    return DateFormat('dd MMMM').format(this);
  }

  String formatHHmm() {
    return DateFormat('HH:mm').format(this);
  }

  bool get isToday {
    return isAtSameDateWithourTime(DateTime.now());
  }
}
