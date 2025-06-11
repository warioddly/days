import 'package:flutter/material.dart';

typedef LengthCalculate = int Function(DateTime from, DateTime to);

typedef DayCalculate = DateTime Function(DateTime start, int compensation);

typedef GridItemBuilder = Widget Function(int index, DateTime date, DateTime now);

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
  State<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {

  int itemsPerRow = 0;
  int length = 0;
  List<List<Widget>> blocks = <List<Widget>>[];
  bool building = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didUpdateWidget(covariant GridBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewSize != widget.viewSize
        || widget.from != oldWidget.from
        || widget.to != oldWidget.to
    ) {
      init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var i = 0; i < blocks.length; i++)
          _itemBuilder(context, i),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {

    final lastElements = blocks[index].length;
    final shouldStartAlign = index == blocks.length - 1
        && lastElements < itemsPerRow;

    return Row(
      mainAxisAlignment: shouldStartAlign
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      children: <Widget>[for (final block in blocks[index]) block],
    );
  }

  void init() {
    calculate();
    blocks = buildItems();
    if (mounted) {
      setState(() {});
    }
  }

  void calculate() {
    final size = widget.viewSize ?? MediaQuery.of(context).size;
    final blockSize = widget.blockSize;
    length = widget.lengthCalculate(widget.from, widget.to);
    itemsPerRow = (size.width / blockSize.width).floor();
  }

  List<List<Widget>> buildItems() {
    final blocks = <List<Widget>>[];

    var index = 0;

    for (var i = 0; i < length; i++) {
      final date = widget.dayCalculate(widget.from, i);

      final position = Offset(
        (index % itemsPerRow).toDouble(),
        (index ~/ itemsPerRow).toDouble(),
      );

      if (position.dx == 0) {
        blocks.add(<Widget>[]);
      }

      blocks.last.add(widget.itemBuilder(index, date, widget.now));

      index++;
    }

    widget.onBuildComplete?.call();

    return blocks;
  }

}
