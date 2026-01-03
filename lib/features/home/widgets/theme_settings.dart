import 'package:days/features/app/app_view_model.dart';
import 'package:days/shared/package/vm/view_model.dart';
import 'package:days/shared/ui/tabs/ui_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final appViewModel = ViewModel.of<AppViewModel>(context);
    return SizedBox(
      width: 165,
      child: UISegmentedControl<ThemeMode>(
        initialIndex: appViewModel.themeMode.index,
        segments: const {
          ThemeMode.system: Icon(CupertinoIcons.circle_lefthalf_fill),
          ThemeMode.light: Icon(CupertinoIcons.sun_max_fill),
          ThemeMode.dark: Icon(CupertinoIcons.moon_stars_fill),
        },
        onValueChanged: (themeMode) => appViewModel.setThemeMode(themeMode),
      ),
    );
  }
}
