import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/presentation/widgets/about/about_app_information.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/settings/settings.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimensions.normal.padding.copyWith(
        top: Dimensions.empty,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Dimensions.half,
        children: [
          text(context, l10n.settings, () => _onSettingsTap(context)),
          DefaultDot(
            size: Dimensions.dotSeparatorSize,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          text(context, l10n.about, () => _onAboutTap(context)),
        ],
      ),
    );
  }

  Widget text(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        )
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
        initialChildSize: 0.3,
        minChildSize: 0.3,
        maxChildSize: 1,
        expand: false,
        builder: (_, _) => const AppSettings(),
      )
    );
  }

  void _onAboutTap(BuildContext context) {
    showCupertinoSheet(
      context: context,
      pageBuilder: (_) =>  const AboutAppInformation(),
    );
  }

}
