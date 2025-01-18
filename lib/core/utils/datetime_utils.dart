import 'package:flutter/material.dart';

class DateTimeUtils {

  static int getDaysFrom(DateTime start, DateTime end) {
    return DateTimeRange(start: start, end: end).duration.inDays;
  }

}