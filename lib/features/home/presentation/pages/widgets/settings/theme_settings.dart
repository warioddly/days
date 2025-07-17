import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/shared/ui/widgets/custom_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, Brightness>(
      builder: (context, state) {
        final selectedThemeIndex = state.index;
        return CustomSegmentedControl(
          initialIndex: state.index,
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
            context.read<ThemeBloc>().add(SetTheme(Brightness.values[index]));
          },
        );
      },
    );
  }
}
