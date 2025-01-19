
import 'package:days/core/utils/datetime_utils.dart';

enum ViewType {
  days,
  weeks,
  months,
  years;

  String get name {
    switch (this) {
      case ViewType.days:
        return 'Days';
      case ViewType.weeks:
        return 'Weeks';
      case ViewType.months:
        return 'Mønths';
      case ViewType.years:
        return 'Years';
    }
  }

  int calculation(DateTime start, DateTime end) {
    return switch (this) {
      ViewType.days => DateTimeUtils.getDaysFrom(start, end),
      ViewType.weeks => DateTimeUtils.getWeeksFrom(start, end),
      ViewType.months => DateTimeUtils.getMonthsFrom(start, end),
      ViewType.years => DateTimeUtils.getYearsFrom(start, end)
    };
  }

  DateTime calculationDay(DateTime start, int compensation) {
    return switch (this) {
      ViewType.days => DateTime(start.year, 1, 0).add(Duration(days: compensation)),
      ViewType.weeks => DateTime(start.year, 1, 0).add(Duration(days: compensation * 7)),
      ViewType.months => DateTime(start.year, start.month + compensation, 0),
      ViewType.years => DateTime(start.year + compensation, 1, 0)
    };
  }

  bool sameWith(DateTime a, DateTime b) {
    return switch (this) {
      ViewType.days => DateTimeUtils.isSameDay(a, b),
      ViewType.weeks => DateTimeUtils.isSameWeek(a, b),
      ViewType.months => DateTimeUtils.isSameMonth(a, b),
      ViewType.years => DateTimeUtils.isSameYear(a, b),
    };
  }

}