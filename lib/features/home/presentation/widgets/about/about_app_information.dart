import 'package:days/core/constants/app_constants.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

const _heartAssets = 'assets/images/icons/illustrations/Heart-9.png';
const _warioddlyImageAssets = 'assets/images/warioddly.png';

class AboutAppInformation extends StatelessWidget {
  const AboutAppInformation({super.key});

  @override
  Widget build(BuildContext context) {

    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      body: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: Dimensions.maxViewWidthSize,
          ),
          child: Padding(
            padding: Dimensions.doubledNormal.padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: Dimensions.large.paddingBottom,
                  child: Image.asset(
                    _heartAssets,
                    color:  isLightTheme ? Colors.black : Colors.white,
                  ),
                ),
                Text(
                  l10n.about_app,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isLightTheme ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrlString(AppConstants.portfolio),
                  child: Padding(
                      padding: Dimensions.normal.paddingTop,
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          invertColors: !isLightTheme,
                        ),
                        child: Image.asset(
                          _warioddlyImageAssets,
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
