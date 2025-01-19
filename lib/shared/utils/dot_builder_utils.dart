import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:days/shared/ui/dot/dot.dart';

class DotBuilderUtils {

  static List<List<Dot>> buildDots({
    required DateTime from,
    required DateTime to,
    required DateTime now,
    required int dotsPerRow,
    double? offset,
    void Function(int index)? beforeOffsetCallback,
  }) {

    assert(from.isBefore(to));

    final days = <List<Dot>>[];

    final yearsInDays = DateTimeUtils.getDaysFrom(from, to);

    for (var i = 0; i < yearsInDays / dotsPerRow; i++) {

      final children = <Dot>[];

      for (var j = 0; j < dotsPerRow; j++) {

        final day = DateTime(from.year, 1, 0).add(Duration(days: i * dotsPerRow + j));

        final isBefore = day.isBefore(now);

        if (isBefore) {
          beforeOffsetCallback?.call(i);
        }

        final position = Vector2(j.toDouble(), i.toDouble());

        final dot = isBefore
            ? Dot.before(position, date: day, isBefore: isBefore)
            : Dot.after(position, date: day, isBefore: isBefore);

        children.add(dot);

      }

      days.add(children);

    }

    return days;
  }



}