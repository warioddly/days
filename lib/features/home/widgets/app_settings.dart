import 'package:days/features/home/widgets/theme_settings.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Borders.xlTop,
      ),
      child: const SafeArea(
        child: Padding(
          padding: Insets.xl,
          child: Center(
            heightFactor: 1,
            child: ThemeSettings(),
          ),
        ),
      ),
    );
  }
}
