import 'package:days/features/home/widgets/about_app_information.dart';
import 'package:days/features/home/widgets/control_bar.dart';
import 'package:days/features/home/widgets/app_settings.dart';
import 'package:days/features/home/widgets/tooltip/tooltip_provider.dart';
import 'package:days/shared/l10n/_locale.dart';
import 'package:days/shared/ui/animations/ui_fade_slide.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/dividers/ui_dot_divider.dart';
import 'package:days/shared/ui/typography/ui_link_text.dart';
import 'package:flutter/material.dart';

class HomeViewFooter extends StatelessWidget {
  const HomeViewFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ControlBar(),
        UIFadeSlide(
          beginOffset: const Offset(0, 0.8),
          child: Padding(
            padding: Insets.m + Insets.mlBottom,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Dimensions.s,
              children: [
                UILinkText(
                  title: l10n.settings,
                  onTap: () {
                    TooltipProvider.of(context).dispose();
                    _showBottomSheet(
                      context,
                      const AppSettings(),
                    );
                  },
                ),
                const UIDotDivider(),
                UILinkText(
                  title: l10n.about,
                  onTap: () {
                    TooltipProvider.of(context).dispose();
                    _showBottomSheet(
                      context,
                      const AboutAppInformation(),
                      showDragHandle: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(
    BuildContext context,
    Widget child, {
    bool? showDragHandle,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      showDragHandle: showDragHandle,
      shape: const RoundedSuperellipseBorder(borderRadius: Borders.xl),
      constraints: const BoxConstraints(maxWidth: double.infinity),
      builder: (_) => child,
    );
  }
}
