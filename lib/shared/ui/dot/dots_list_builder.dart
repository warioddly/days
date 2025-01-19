import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/shared/ui/dot/dot.dart';
import 'package:flutter/material.dart';

class DotsListBuilder extends StatelessWidget {
  const DotsListBuilder({super.key, required this.days});

  final List<List<Dot>> days;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
      (_, index) {
          return Container(
            margin: (Dimensions.dotContainerSize / 2 + Dimensions.dotSize).paddingHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (final dot in days[index])
                  dot
              ],
            ),
          );
        },
        childCount: days.length,
      ),
    );
  }
}
