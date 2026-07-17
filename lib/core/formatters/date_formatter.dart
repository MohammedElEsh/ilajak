import 'package:intl/intl.dart';

abstract class DateFormatter {
  static String formatToYMD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatToReadable(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatToTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static String formatToDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy hh:mm a').format(date);
  }

  static String formatToISO8601(DateTime date) {
    return date.toIso8601String();
  }

  static DateTime? parseFromYMD(String date) {
    try {
      return DateFormat('yyyy-MM-dd').parse(date);
    } catch (_) {
      return null;
    }
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    }
    return 'Just now';
  }
}
