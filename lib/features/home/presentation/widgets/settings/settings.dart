import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/settings/related_links.dart';
import 'package:days/features/home/presentation/widgets/settings/theme_settings.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: Insets.normal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Dimensions.small,
            children: [
              ThemeSettings(),
              RelatedLinks(),
            ],
          ),
        ),
      ),
    );
  }
}
