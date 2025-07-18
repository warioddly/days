import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/pages/widgets/settings/theme_settings.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Borders.xlTop,
      ),
      padding: Insets.m,
      width: double.infinity,
      child: const SafeArea(
        child: Padding(
          padding: Insets.m,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Dimensions.sm,
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeSettings(),
            ],
          ),
        ),
      ),
    );
  }
}
