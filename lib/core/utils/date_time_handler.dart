import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeHandler {
  static String formatDate(DateTime dateTime) => DateFormat('EEE, MMM dd').format(dateTime);

  static String formatTime(DateTime dateTime) => DateFormat('hh:mm a').format(dateTime);

  static String formatDateTime(DateTime dateTime) =>
      '${formatTime(dateTime)} - ${formatDate(dateTime)}';

  static String formatDateInWord(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.isNegative) {
      // Past dates
      return timeago.format(dateTime);
    } else {
      // Future dates
      return timeago.format(dateTime, allowFromNow: true);
    }
  }

  static String getCurrentDate() => formatDate(DateTime.now());

  static String getCurrentTime() => formatTime(DateTime.now());

  static String getCurrentDateTime() => formatDateTime(DateTime.now());
}
