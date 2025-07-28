import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme_notifier.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/animations/utils/curves.dart';
import 'package:flutter/cupertino.dart';

const _dotSize = 5.0;

class DotedDot extends Dot {
  const DotedDot({
    super.key,
    super.date,
    super.color,
    super.isActive = true,
    super.onEnable,
    super.onDisable,
  });

  @override
  State<DotedDot> createState() => _DotedDotState();
}

class _DotedDotState extends DotState<DotedDot> {

  final dot = DefaultDot(
    color: CupertinoColors.tertiarySystemFill.darkHighContrastColor,
    size: _dotSize,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isActive && mounted) {
        widget.onEnable?.call();
        controller.setActive(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: Dimensions.dotContainerSize,
      child: ListenableBuilder(
        listenable: Listenable.merge([
          ThemeNotifier.of(context),
          controller,
        ]),
        builder: (context, _) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            reverseDuration: const Duration(milliseconds: 250),
            switchInCurve: SharedCurves.bounceAnimation,
            switchOutCurve: Curves.fastEaseInToSlowEaseOut,
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: isActive
                ? DefaultDot(
              key: ObjectKey(widget.date?.toIso8601String() ?? ''),
              color: context.colorScheme.onPrimary,
              size: _dotSize,
            ) : dot,
          );
        },
      ),
    );
  }

  @override
  void enable() {
    if (isActive || !mounted) {
      return;
    }
    controller.setActive(true);
    widget.onEnable?.call();
  }

  @override
  void disable([bool shouldDisableActive = false]) {
    if (!isActive || (shouldDisableActive && widget.isActive)) {
      return;
    }
    controller.setActive(false);
    widget.onDisable?.call();
  }


}
