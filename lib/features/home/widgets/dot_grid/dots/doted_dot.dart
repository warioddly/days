import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/home/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
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
        listenable: controller,
        builder: (context, _) {
          return buildDotSwitcher(
            duration: const Duration(milliseconds: 250),
            reverseDuration: const Duration(milliseconds: 250),
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


}
