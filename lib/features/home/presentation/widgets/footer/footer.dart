import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/presentation/widgets/about/about_app_information.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/settings/settings.dart';
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
        spacing: Dimensions.small,
        children: [
          text(context, 'SETTINGS', () => _onSettingsTap(context)),
          DefaultDot(
            size: Dimensions.dotSeparatorSize,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          text(context, 'ABOUT', () => _onAboutTap(context)),
        ],
      ),
    );
  }

  Widget text(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        )
      ),
    );
  }

  void _onSettingsTap(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      builder: (_) => const AppSettings() ,
    );
  }

  void _onAboutTap(BuildContext context) {
    showCupertinoSheet(
      context: context,
      pageBuilder: (_) =>  const AboutAppInformation(),
    );
  }

}
