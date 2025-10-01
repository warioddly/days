import 'package:days/features/app/presentation/bloc/theme_notifier.dart';
import 'package:days/shared/ui/tabs/ui_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeNotifier.of(context);
    return SizedBox(
      width: 165,
      child: UISegmentedControl<ThemeMode>(
        initialIndex: ThemeNotifier.value(context).index,
        segments: const {
          ThemeMode.system: Icon(
            CupertinoIcons.circle_lefthalf_fill
          ),
          ThemeMode.light: Icon(
            CupertinoIcons.sun_max_fill,
          ),
          ThemeMode.dark: Icon(
            CupertinoIcons.moon_stars_fill,
          ),
        },
        onValueChanged: (themeMode) => themeNotifier.setTheme(themeMode),
      ),
    );
  }
}
