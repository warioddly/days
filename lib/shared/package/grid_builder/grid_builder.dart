import 'package:flutter/material.dart';

typedef LengthCalculate = int Function(DateTime from, DateTime to);

typedef DayCalculate = DateTime Function(DateTime start, int compensation);

typedef GridItemBuilder = Widget Function(int index, DateTime date, DateTime now);

class GridBuilder extends StatelessWidget {
  const GridBuilder({
    required this.now,
    required this.from,
    required this.to,
    required this.blockSize,
    required this.lengthCalculate,
    required this.dayCalculate,
    required this.itemBuilder,
    super.key,
    this.viewSize,
    this.onBuildComplete,
  });

  final DateTime now;
  final DateTime from;
  final DateTime to;
  final Size blockSize;
  final Size? viewSize;
  final LengthCalculate lengthCalculate;
  final DayCalculate dayCalculate;
  final GridItemBuilder itemBuilder;
  final VoidCallback? onBuildComplete;

  @override
  Widget build(BuildContext context) {

    final size = viewSize ?? MediaQuery.of(context).size;
    final length = lengthCalculate(from, to);
    final itemsPerRow = (size.width / blockSize.width).floor();

    final blocks = <List<Widget>>[];

    var index = 0;

    for (var i = 0; i < length; i++) {
      final date = dayCalculate(from, i);

      final position = Offset(
        (index % itemsPerRow).toDouble(),
        (index ~/ itemsPerRow).toDouble(),
      );

      if (position.dx == 0) {
        blocks.add(<Widget>[]);
      }

      blocks.last.add(itemBuilder(index, date, now));

      index++;
    }

    onBuildComplete?.call();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var i = 0; i < blocks.length; i++)
          () {
            final lastElements = blocks[i].length;
            final shouldStartAlign = i == blocks.length - 1
                && lastElements < itemsPerRow;

            return Row(
              mainAxisAlignment: shouldStartAlign
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: <Widget>[for (final block in blocks[i]) block],
            );
          }()
      ],
    );
  }
}
