import 'package:days/core/constants/app_constants.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:days/shared/ui/widgets/dot_separator.dart';
import 'package:days/shared/ui/widgets/linked_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RelatedLinks extends StatelessWidget {
  const RelatedLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Dimensions.half,
      children: [
        LinkedText(
          title: l10n.github,
          onPressed: () => launchUrlString(AppConstants.sourceCodeUrl),
        ),
        const DotSeparator(),
        LinkedText(
          title: l10n.privacy,
          onPressed: () => launchUrlString(AppConstants.privacyUrl),
        ),
      ],
    );
  }
}
