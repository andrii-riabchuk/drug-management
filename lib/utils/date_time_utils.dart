import 'dart:math';

import 'package:intl/intl.dart';

class DateTimeUtils {
  static const formatString = 'yyyy-MM-dd HH:mm:ss';

  // Formatting
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(formatString).format(dateTime);
  }

  static String utcNowFormatted() {
    return formatDateTime(DateTime.now().toUtc());
  }

  static DateTime parseUtcFormatted(String str) {
    return DateFormat(formatString).parse(str, true).toLocal();
  }

  // Calculations
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    var diff = (to.difference(from).inHours / 24).round();
    return max(diff, 0);
  }
}

extension DateTimeExtension on DateTime {
  DateTime plus({int days = 0}) {
    return this.add(Duration(days: days));
  }
}
