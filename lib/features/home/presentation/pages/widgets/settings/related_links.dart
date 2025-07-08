import 'package:days/core/constants/constants.dart';
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
    final color = Theme.of(context).colorScheme.secondary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Dimensions.s,
      children: [
        LinkedText(
          title: l10n.terms,
          onPressed: () => launchUrlString(Constants.termsUrl),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: color,
          ),
        ),
        DotSeparator(color: color),
        LinkedText(
          title: l10n.privacy,
          onPressed: () => launchUrlString(Constants.privacyUrl),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}
