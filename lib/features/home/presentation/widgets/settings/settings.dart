import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/settings/theme_settings.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.doubledNormal),
          topRight: Radius.circular(Dimensions.doubledNormal),
        ),
      ),
      padding: Insets.normal,
      width: double.infinity,
      child: const SafeArea(
        child: Padding(
          padding: Insets.normal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Dimensions.small,
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
