import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:days/features/home/presentation/widgets/tooltip/tooltip_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Tooltip extends StatelessWidget {
  const Tooltip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<TooltipController>(
      builder: (context, value, child) {

        final content = DateTimeUtils.format(value.content);
        final position = value.position - getPositionCompensation(context);

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
          left: position.dx,
          top: position.dy,
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              opacity: value.isVisible ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.small,
                  vertical: Dimensions.half,
                ),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: Dimensions.small.allBorder,
                  border: Border.all(
                    color: theme.colorScheme.onPrimary,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onPrimary.withAlpha(70),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  content,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Offset getPositionCompensation(BuildContext context) {

    if (kIsWeb && MediaQuery.sizeOf(context).width < 600) {
        return const Offset(40, 55);
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.android: return const Offset(40, 110);
      default: return const Offset(40, 45);
    }
  }

}
