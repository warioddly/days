import 'package:days/core/constants/constants.dart';
import 'package:days/shared/l10n/_locale.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/dividers/ui_dot_divider.dart';
import 'package:days/shared/ui/typography/ui_link_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RelatedLinks extends StatelessWidget {
  const RelatedLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    final typography = Theme.of(context).textTheme.labelLarge?.copyWith(
      color: color,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Dimensions.s,
      children: [
        UILinkText(
          title: l10n.terms,
          onPressed: () => launchUrlString(kTermsUrl),
          style: typography,
        ),
        UIDotDivider(color: color),
        UILinkText(
          title: l10n.privacy,
          onPressed: () => launchUrlString(kPrivacyUrl),
          style: typography,
        ),
      ],
    );
  }
}
