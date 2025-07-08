import 'package:days/core/constants/constants.dart';
import 'package:days/core/constants/breakpoints.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/pages/widgets/settings/related_links.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

const _heartAssets = 'assets/images/icons/illustrations/Heart-9.png';
const _warioddlyImageAssets = 'assets/images/warioddly.png';

class AboutAppInformation extends StatelessWidget {
  const AboutAppInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.brightnessOf(context) == Brightness.light;

    return Scaffold(
      body: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxViewWidthSize),
          child: Padding(
            padding: Insets.xl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: Insets.mBottom,
                  child: Image.asset(
                    _heartAssets,
                    color: isLightTheme ? Colors.black : Colors.white,
                  ),
                ),
                Text(
                  l10n.about_app,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: isLightTheme ? Colors.black : Colors.white, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => launchUrlString(Constants.portfolio),
                  child: Padding(
                    padding: Insets.mTop,
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(invertColors: !isLightTheme),
                      child: Image.asset(_warioddlyImageAssets),
                    ),
                  ),
                ),
                const Spacer(),
                const RelatedLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
