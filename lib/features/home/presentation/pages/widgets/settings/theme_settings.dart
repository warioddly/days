import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme_notifier.dart';
import 'package:days/shared/ui/widgets/custom_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeNotifier.of(context),
      builder: (context, state) {
        final selectedThemeIndex = ThemeNotifier.value(context).index;
        return CustomSegmentedControl(
          initialIndex: selectedThemeIndex,
          segments: [
            Icon(
                CupertinoIcons.moon_stars_fill,
                color: selectedThemeIndex == Brightness.dark.index
                    ? context.colorScheme.onPrimary
                    : CupertinoColors.systemFill,
            ),
            Icon(
                CupertinoIcons.sun_max_fill,
              color: selectedThemeIndex == Brightness.light.index
                  ? context.colorScheme.onPrimary
                  : CupertinoColors.systemFill,
            ),
          ],
          onValueChanged: (index) {
            if (selectedThemeIndex == index) {
              return;
            }
            HapticFeedback.selectionClick();
            ThemeNotifier.of(context).setTheme = Brightness.values[index];
          },
        );
      },
    );
  }
}
