import 'package:days/core/constants/constants.dart';
import 'package:days/features/home/widgets/settings/related_links.dart';
import 'package:days/shared/l10n/_locale.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/layouts/layout_breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        child: LayoutBreakpoint(
          child: Padding(
            padding: Insets.xl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  _heartAssets,
                  color: isLightTheme ? Colors.black : Colors.white,
                ),
                Spaces.m,
                Text(
                  l10n.about_app,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isLightTheme ? Colors.black : Colors.white,
                    fontSize: 14,
                  ),
                ),
                Spaces.m,
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    launchUrlString(kPortfolio);
                  },
                  child: MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(invertColors: !isLightTheme),
                    child: Image.asset(_warioddlyImageAssets),
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
