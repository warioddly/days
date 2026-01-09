import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/home/dot_manager.dart';
import 'package:days/features/home/home_view_model.dart';
import 'package:days/shared/l10n/_locale.dart';
import 'package:days/shared/package/animated_flip_counter/animated_flip_counter.dart';
import 'package:days/shared/package/vm/view_model.dart';
import 'package:days/shared/ui/animations/ui_blur_switcher.dart';
import 'package:days/shared/ui/animations/ui_fade_slide.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:flutter/cupertino.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return UIFadeSlide(
      beginOffset: const Offset(0, -.8),
      child: Padding(
        padding: Insets.xl,
        child: Center(
          child: Column(
            children: [
              RepaintBoundary(
                child: Builder(
                  builder: (context) => AnimatedFlipCounter(
                    value: DotManager.of(context).counter,
                    duration: const Duration(seconds: 2),
                    curve: Curves.linearToEaseOut,
                    textStyle: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spaces.xs,
              Builder(
                builder: (context) => UIBlurSwitcher(
                  child: Text(
                    key: UniqueKey(),
                    switch (ViewModel.of<HomeViewModel>(context).gridType) {
                      GridType.illustrated => l10n.more_days_of_growth,
                      GridType.doted => l10n.days_left_in_the_year(
                        DateTime.now().year,
                      ),
                    },
                    style: context.textTheme.labelLarge?.copyWith(
                      color: CupertinoColors
                          .tertiarySystemFill
                          .darkHighContrastColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
