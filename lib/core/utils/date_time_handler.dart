import 'package:intl/intl.dart';

class DateTimeHandler {
  static String formatDate(DateTime dateTime) => DateFormat('EEE, MMM dd').format(dateTime);

  static String formatTime(DateTime dateTime) => DateFormat('hh:mm a').format(dateTime);

  static String formatDateTime(DateTime dateTime) =>
      '${formatTime(dateTime)} - ${formatDate(dateTime)}';

  static String formatDateInWord(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final difference = dateOnly.difference(today).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    } else {
      return DateFormat('EEE, dd MMM').format(dateTime);
    }
  }

  static String getCurrentDate() => formatDate(DateTime.now());

  static String getCurrentTime() => formatTime(DateTime.now());

  static String getCurrentDateTime() => formatDateTime(DateTime.now());

  static bool isSameDate(DateTime date1, DateTime date2) =>
      date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;

  static bool isToday(DateTime date) => isSameDate(date, DateTime.now());

  static bool isSameDateTime(DateTime date1, DateTime date2) => date1.isAtSameMomentAs(date2);

  static bool isBeforeToday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    return dateOnly.isBefore(today);
  }

  static bool isAfterToday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    return dateOnly.isAfter(today);
  }

  static bool isBeforeDate(DateTime date, DateTime comparison) => date.isBefore(comparison);

  static bool isAfterDate(DateTime date, DateTime comparison) => date.isAfter(comparison);
}
