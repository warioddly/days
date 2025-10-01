import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/ui_curves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UISegmentedControl<T> extends StatefulWidget {
  final Map<T, Widget> segments;
  final ValueChanged? onValueChanged;
  final int initialIndex;

  const UISegmentedControl({
    required this.segments,
    this.onValueChanged,
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<UISegmentedControl> createState() => _UISegmentedControlState();
}

class _UISegmentedControlState extends State<UISegmentedControl>
    with TickerProviderStateMixin {
  late final bounceAnimation = CurvedAnimation(
    parent: bounceAnimationController,
    curve: Curves.easeInOutCubicEmphasized,
    reverseCurve: Curves.bounceOut.flipped,
  );

  late final bounceAnimationController = AnimationController(
    duration: Durations.short3,
    vsync: this,
    lowerBound: 1,
    upperBound: 1.07,
    reverseDuration: Durations.short4,
  );

  late final selectedIndex = ValueNotifier(widget.initialIndex);

  @override
  void didUpdateWidget(UISegmentedControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.initialIndex != selectedIndex.value) {
    //   selectedIndex.value = widget.initialIndex;
    // }
  }

  @override
  void dispose() {
    bounceAnimationController.dispose();
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final controlBarWidth = constraints.maxWidth;
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
            child: SizedBox(
              height: 50,
              width: controlBarWidth,
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  color: CupertinoColors.tertiarySystemFill,
                  shape: RoundedSuperellipseBorder(borderRadius: Borders.msl),
                ),
                child: Stack(
                  children: [
                    ListenableBuilder(
                      listenable: selectedIndex,
                      builder: (_, child) => AnimatedPositioned(
                        duration: Durations.long3,
                        curve: UICurves.bounceSwitchAnimation,
                        left: selectedIndex.value * segmentWidth,
                        top: 0,
                        bottom: 0,
                        width: segmentWidth,
                        child: Padding(
                          padding: Insets.xs,
                          child: DecoratedBox(
                            decoration: ShapeDecoration(
                              color: context.colorScheme.primary,
                              shape: const RoundedSuperellipseBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14.0),
                                ),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < widget.segments.length; i++)
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                widget.onValueChanged?.call(
                                  widget.segments.keys.toList()[i],
                                );
                                selectedIndex.value = i;
                              },
                              child: Center(
                                child: widget.segments.values.toList()[i],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
