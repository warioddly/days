import 'package:days/shared/models/vector2.dart';
import 'package:days/shared/ui/dot/dot.dart';
import 'package:days/shared/utils/enums/view_type_enum.dart';
import 'package:flutter/material.dart';

class DotBuilderUtils {

  static List<List<Dot>> buildDots({
    required DateTime from,
    required DateTime to,
    required DateTime now,
    required ViewType viewType,
    required int dotsPerRow,
    double? offset,
    void Function(int index)? beforeOffsetCallback,
  }) {

    assert(from.isBefore(to));

    final days = <List<Dot>>[], length = viewType.calculation(from, to);

    for (var i = 0; i < length / dotsPerRow; i++) {

      final children = <Dot>[];

      for (var j = 0; j < dotsPerRow; j++) {

        final day = viewType.calculationDay(from, i * dotsPerRow + j);

        final isBefore = day.isBefore(now);

        if (isBefore) {
          beforeOffsetCallback?.call(i);
        }

        final position = Vector2(j.toDouble(), i.toDouble());

        final dot = viewType.sameWith(day, now)
              ? Dot(position, date: day, color: Colors.tealAccent)
              : isBefore
                ? Dot.before(position, date: day, isBefore: isBefore)
                : Dot.after(position, date: day, isBefore: isBefore);

        children.add(dot);

      }

      days.add(children);

    }

    return days;
  }



}