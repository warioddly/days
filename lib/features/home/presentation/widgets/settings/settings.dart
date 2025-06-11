import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/settings/related_links.dart';
import 'package:days/features/home/presentation/widgets/settings/theme_settings.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Dimensions.maxViewWidthSize),
        child: const Scaffold(
          body: Padding(
            padding: Insets.normal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ThemeSettings(),
                RelatedLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
