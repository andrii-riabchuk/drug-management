import 'dart:math';

import 'package:intl/intl.dart';

class DateTimeUtils {
  static const formatString = 'yyyy-MM-dd HH:mm:ss';
  static const shortFormat = "yyyy-MM-dd";

  static String utcNowFormatted() {
    return DateTime.now().toUtc().formatDateTime();
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
    return add(Duration(days: days));
  }
}

extension DateTimeExtensions on DateTime {
  String formatDateTime() {
    return DateFormat(DateTimeUtils.formatString).format(this);
  }

  String formatDateTimeShort() {
    return DateFormat(DateTimeUtils.shortFormat).format(this);
  }

  String formatDateWithWords() {
    return DateFormat.yMMMd("en_US").format(this);
  }
}
