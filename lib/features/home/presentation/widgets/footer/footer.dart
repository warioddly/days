import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/about/about_app_information.dart';
import 'package:days/features/home/presentation/widgets/settings/settings.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:days/shared/ui/widgets/dot_separator.dart';
import 'package:days/shared/ui/widgets/linked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Insets.normal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Dimensions.half,
          children: [
            LinkedText(
              title: l10n.settings,
              onPressed: () => _onSettingsTap(context),
            ),
            const DotSeparator(),
            LinkedText(title: l10n.about, onPressed: () => _onAboutTap(context)),
          ],
        ),
      ),
    );
  }

  void _onSettingsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.18,
        minChildSize: 0.18,
        maxChildSize: 1,
        expand: false,
        builder: (_, _) => const AppSettings(),
      ),
    );
  }

  void _onAboutTap(BuildContext context) {
    showCupertinoSheet(
      context: context,
      pageBuilder: (_) => const AboutAppInformation(),
    );
  }
}
