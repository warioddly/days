import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/presentation/widgets/settings/localization_settings.dart';
import 'package:days/features/home/presentation/widgets/settings/related_links.dart';
import 'package:days/features/home/presentation/widgets/settings/theme_settings.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: Dimensions.maxViewWidthSize),
      child: Scaffold(
        body: Padding(
          padding: Dimensions.normal.padding,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                spacing: Dimensions.normal,
                children: [LocalizationSettings(), ThemeSettings()],
              ),
              RelatedLinks(),
            ],
          ),
        ),
      ),
    );
  }
}
