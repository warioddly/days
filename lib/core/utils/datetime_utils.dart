import 'package:flutter/material.dart';

class DateTimeUtils {
  static int getDaysFrom(DateTime start, DateTime end) {
    print("DateTimeRange(start: start, end: end).duration.inDays ${DateTimeRange(start: start, end: end).duration.inDays}");
    return DateTimeRange(start: start, end: end).duration.inDays;
  }

  static int getWeeksFrom(DateTime start, DateTime end) {
    return DateTimeRange(start: start, end: end).duration.inDays ~/ 7;
  }

  static int getMonthsFrom(DateTime start, DateTime end) {
    return (end.year - start.year) * 12 + end.month - start.month;
  }

  static int getYearsFrom(DateTime start, DateTime end) {
    return end.year - start.year;
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.weekday == b.weekday;
  }

  static bool isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

  static bool isSameYear(DateTime a, DateTime b) {
    return a.year == b.year;
  }
}
