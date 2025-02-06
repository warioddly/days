import 'package:days/shared/models/vector2.dart';
import 'package:flutter/material.dart';

typedef LengthCalculate = int Function(DateTime from, DateTime to);

typedef DayCalculate = DateTime Function(DateTime start, int compensation);

typedef ItemBuilder = Widget Function(
    int index, DateTime date, Vector2 position);

typedef OnBuildComplete = Widget Function(double currentDayOffset);

class GridBuilder extends StatefulWidget {
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
    this.padding = EdgeInsets.zero,
  });

  final DateTime now;
  final DateTime from;
  final DateTime to;
  final Size blockSize;
  final Size? viewSize;
  final LengthCalculate lengthCalculate;
  final DayCalculate dayCalculate;
  final ItemBuilder itemBuilder;
  final OnBuildComplete? onBuildComplete;
  final EdgeInsets padding;

  @override
  State<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  int itemsPerRow = 0;
  int itemsPerColumn = 0;
  int length = 0;
  var blocks = <List<Widget>>[];

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didUpdateWidget(covariant GridBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    init();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: widget.padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[for (final block in blocks[index]) block],
            );
          },
          childCount: blocks.length,
        ),
      ),
    );
  }

  void init() {
    Future.delayed(Duration.zero, () {
      calculate();
      blocks = buildItems();
      if (mounted) {
        setState(() {});
      }
    });
  }

  void calculate() {
    final size = widget.viewSize ?? MediaQuery.of(context).size;
    final blockSize = widget.blockSize;

    length = widget.lengthCalculate(widget.from, widget.to);
    itemsPerRow =
        ((size.width - (blockSize.width / 2 + widget.padding.horizontal) * 2) ~/
            blockSize.width);
    itemsPerColumn = size.height ~/ blockSize.height;
  }

  List<List<Widget>> buildItems() {
    final blocks = <List<Widget>>[];
    var currentDayOffset = 0.0;

    for (var i = 0; i < length / itemsPerRow; i++) {
      final children = <Widget>[];

      for (var j = 0; j < itemsPerRow; j++) {
        int index = i * itemsPerRow + j;

        final day = widget.dayCalculate(widget.from, index);
        final position = Vector2(j.toDouble(), i.toDouble());
        final isBefore = day.isBefore(widget.now);

        if (isBefore) {
          currentDayOffset = (i * widget.blockSize.height) + itemsPerColumn;
        }

        final item = widget.itemBuilder.call(index, day, position);

        children.add(item);
      }

      blocks.add(children);
    }

    widget.onBuildComplete?.call(currentDayOffset);

    return blocks;
  }
}
