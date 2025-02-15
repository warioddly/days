import 'package:days/core/constants/app_constants.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutAppInformationFooter extends StatelessWidget {
  const AboutAppInformationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Dimensions.small,
      children: [

        GestureDetector(
          onTap: () => launchUrlString(AppConstants.sourceCodeUrl),
          child: const Text(
            'github',
          ),
        ),
        const DefaultDot(size: Dimensions.dotSeparatorSize),
        GestureDetector(
          onTap: () => launchUrlString(AppConstants.privacyUrl),
          child: const Text(
            'privacy',
          ),
        ),

      ],
    );
  }
}
