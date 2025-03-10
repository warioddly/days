import 'package:days/core/constants/app_constants.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RelatedLinks extends StatelessWidget {
  const RelatedLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Dimensions.small,
      children: [
        GestureDetector(
          onTap: () => launchUrlString(AppConstants.sourceCodeUrl),
          child: Text(
            l10n.github,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        DefaultDot(
          size: Dimensions.dotSeparatorSize,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        GestureDetector(
          onTap: () => launchUrlString(AppConstants.privacyUrl),
          child: Text(
            l10n.privacy,
            style: Theme.of(context).textTheme.bodySmall
          ),
        ),
      ],
    );
  }
}
