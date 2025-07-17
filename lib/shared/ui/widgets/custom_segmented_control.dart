

import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSegmentedControl extends StatefulWidget {
  final List<Widget> segments;
  final ValueChanged<int> onValueChanged;
  final int initialIndex;

  const CustomSegmentedControl({
    required this.segments,
    required this.onValueChanged,
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<CustomSegmentedControl> createState() => _CustomSegmentedControlState();
}

class _CustomSegmentedControlState extends State<CustomSegmentedControl>
    with TickerProviderStateMixin {
  late final Animation bounceAnimation = CurvedAnimation(
    parent: bounceAnimationController,
    curve: Curves.easeInOutCubicEmphasized,
    reverseCurve: Curves.bounceOut.flipped,
  );

  late final bounceAnimationController = AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
    lowerBound: 1,
    upperBound: 1.07,
    reverseDuration: const Duration(milliseconds: 180),
  );

  late final selectedIndex = ValueNotifier<int>(widget.initialIndex);

  @override
  void didUpdateWidget(CustomSegmentedControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != selectedIndex.value) {
      selectedIndex.value = widget.initialIndex;
    }
  }

  @override
  void dispose() {
    bounceAnimationController.dispose();
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const controlBarWidth = 110.0;
    final segmentWidth = controlBarWidth / widget.segments.length;
    return GestureDetector(
      onTapDown: (_) {
        bounceAnimationController.forward();
        HapticFeedback.mediumImpact();
      },
      onTapCancel: () {
        bounceAnimationController.reverse();
        HapticFeedback.mediumImpact();
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: bounceAnimationController,
        builder: (context, child) {
          return Transform.scale(
            scale: bounceAnimationController.value,
            child: child,
          );
        },
        child: Container(
          height: 50,
          width: controlBarWidth,
          decoration: BoxDecoration(
            color: CupertinoColors.tertiarySystemFill,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListenableBuilder(
            listenable: selectedIndex,
            builder: (context, child) => child!,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 550),
                  curve: const ThreePointCubic(
                    Offset(0.056, 0.024),
                    Offset(0.208, 0.3085),
                    Offset(0.322, .99),
                    Offset(0.421, 1.16),
                    Offset(0.546, 1.0),
                  ),
                  left: selectedIndex.value * segmentWidth,
                  top: 0,
                  bottom: 0,
                  width: segmentWidth,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: List.generate(widget.segments.length, (index) {
                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          selectedIndex.value = index;
                          widget.onValueChanged(index);
                        },
                        child: Center(child: widget.segments[index]),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
