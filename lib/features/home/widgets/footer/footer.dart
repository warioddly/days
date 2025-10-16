import 'package:days/features/home/widgets/about/about_app_information.dart';
import 'package:days/features/home/widgets/settings/settings.dart';
import 'package:days/shared/l10n/_locale.dart';
import 'package:days/shared/ui/animations/ui_fade_slide.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/dividers/ui_dot_divider.dart';
import 'package:days/shared/ui/typography/ui_link_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return UIFadeSlide(
      beginOffset: const Offset(0, 0.8),
      child: Padding(
        padding: Insets.m + Insets.mlBottom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Dimensions.s,
          children: [
            UILinkText(
              title: l10n.settings,
              onPressed: () => _onSettingsTap(context),
            ),
            const UIDotDivider(),
            UILinkText(
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
      shape: const RoundedSuperellipseBorder(
        borderRadius: Borders.m,
      ),
      builder: (_) => const AppSettings(),
    );
  }

  void _onAboutTap(BuildContext context) {
    showCupertinoSheet(
      context: context,
      builder: (_) => const AboutAppInformation(),
    );
  }
}
