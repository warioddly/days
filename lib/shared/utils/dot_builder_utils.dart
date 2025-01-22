import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:days/shared/ui/dot/dot.dart';
import 'package:flutter/material.dart';

class DotBuilderUtils {

  static List<List<Dot>> buildDots({
    required DateTime from,
    required DateTime to,
    required DateTime now,
    required GridType gridType,
    required int dotsPerRow,
    double? offset,
    void Function(int index)? beforeOffsetCallback,
  }) {

    final days = <List<Dot>>[], length = gridType.calculation(from, to);

    for (var i = 0; i < length / dotsPerRow; i++) {

      final children = <Dot>[];

      for (var j = 0; j < dotsPerRow; j++) {

        final day = gridType.calculationDay(from, i * dotsPerRow + j);

        final isBefore = day.isBefore(now);

        if (isBefore) {
          beforeOffsetCallback?.call(i);
        }

        final position = Vector2(j.toDouble(), i.toDouble());

        final dot = gridType.sameWith(day, now)
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