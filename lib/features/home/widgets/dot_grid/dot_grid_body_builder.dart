import 'package:days/core/constants/breakpoints.dart';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/grids/grid_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DotGridBodyBuilder extends StatelessWidget {
  const DotGridBodyBuilder({
    required this.now,
    required this.onPanUpdate,
    required this.itemBuilder,
    this.onBuildComplete,
    super.key,
  });

  final DateTime now;
  final ValueChanged<Offset> onPanUpdate;
  final VoidCallback? onBuildComplete;
  final GridItemBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {

    final mediaQuerySize = MediaQuery.sizeOf(context);
    final viewSize = (mediaQuerySize.width > Breakpoints.maxViewWidthSize
        ? Breakpoints.maxViewWidthSize
        : mediaQuerySize.width) -
        (Dimensions.xl * 2);

    return Center(
      child: Padding(
        padding: Insets.xlHorizontal,
        child: SizedBox(
          width: double.infinity,
          height: viewSize / ((viewSize / 2) / (mediaQuerySize.height / 4)),
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) => onPanUpdate(details.globalPosition),
              onPanUpdate: (details) => onPanUpdate(details.globalPosition),
              child: GridBuilder(
                now: now,
                from: DateTime(now.year),
                to: DateTime(now.year).add(const Duration(days: 365)),
                lengthCalculate: DateTimeUtils.getDaysFrom,
                dayCalculate: DateTimeUtils.addDays,
                blockSize: const Size.square(Dimensions.dotContainerSize),
                viewSize: Size(viewSize, mediaQuerySize.height),
                itemBuilder: itemBuilder,
                onBuildComplete: onBuildComplete,
              ),
            ),
          ),
        ),
      ),
    );

  }
}
