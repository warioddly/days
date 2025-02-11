import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';

extension GridTypeExtension on GridType {
  int calculation(DateTime start, DateTime end) {
    return switch (this) {
      GridType.days => DateTimeUtils.getDaysFrom(start, end),
      GridType.weeks => DateTimeUtils.getWeeksFrom(start, end),
      GridType.months => DateTimeUtils.getMonthsFrom(start, end),
      // GridType.years => DateTimeUtils.getYearsFrom(start, end)
    };
  }

  DateTime calculationDay(DateTime start, int compensation) {
    return switch (this) {
      GridType.days => DateTime(start.year).add(Duration(days: compensation)),
      GridType.weeks =>
        DateTime(start.year).add(Duration(days: compensation * 7)),
      GridType.months => DateTime(start.year, start.month + compensation, 1),
      // GridType.years => DateTime(start.year + compensation, 1, 0)
    };
  }

  bool sameWith(DateTime a, DateTime b) {
    return switch (this) {
      GridType.days => DateTimeUtils.isSameDay(a, b),
      GridType.weeks => DateTimeUtils.isSameWeek(a, b),
      GridType.months => DateTimeUtils.isSameMonth(a, b),
      // GridType.years => DateTimeUtils.isSameYear(a, b),
    };
  }
}
