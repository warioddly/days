import 'package:days/shared/models/vector2.dart';
import 'package:flutter/material.dart';

typedef LengthCalculate = int Function(DateTime from, DateTime to);

typedef DayCalculate = DateTime Function(DateTime start, int compensation);

typedef ItemBuilder = Widget Function(
    int index, DateTime date, Vector2 position);

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
  final VoidCallback? onBuildComplete;
  final EdgeInsets padding;

  @override
  State<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {

  int itemsPerRow = 0;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        for (var i = 0; i < blocks.length; i++)
          _itemBuilder(context, i),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Row(
      children: <Widget>[for (final block in blocks[index]) block],
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
    (((size.width - (blockSize.width / 2 + widget.padding.horizontal)) ~/
        blockSize.width));
  }

  List<List<Widget>> buildItems() {
    final blocks = <List<Widget>>[];

    var index = 0;

    for (var i = 0; i < length; i++) {
      final date = widget.dayCalculate(widget.from, i);
      final position = Vector2(
        (index % itemsPerRow).toDouble(),
        (index ~/ itemsPerRow).toDouble(),
      );

      if (position.x == 0) {
        blocks.add(<Widget>[]);
      }

      blocks.last.add(widget.itemBuilder(index, date, position));

      index++;
    }

    widget.onBuildComplete?.call();

    return blocks;
  }

}
