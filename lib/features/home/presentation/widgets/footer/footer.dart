import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/about/about_app_information.dart';
import 'package:days/features/home/presentation/widgets/settings/settings.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:days/shared/ui/animations/fade_slide_animation.dart';
import 'package:days/shared/ui/widgets/dot_separator.dart';
import 'package:days/shared/ui/widgets/linked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return FadeSlideAnimation(
      beginOffset: const Offset(0, 0.8),
      child: Padding(
        padding: Insets.m + Insets.mlBottom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Dimensions.s,
          children: [
            LinkedText(
              title: l10n.settings,
              onPressed: () => _onSettingsTap(context),
            ),
            const DotSeparator(),
            LinkedText(
              title: l10n.about,
              onPressed: () => _onAboutTap(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onSettingsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AppSettings(),
    );
  }

  void _onAboutTap(BuildContext context) {
    showCupertinoSheet(
      context: context,
      pageBuilder: (_) => const AboutAppInformation(),
    );
  }
}
