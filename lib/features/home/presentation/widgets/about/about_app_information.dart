import 'package:days/core/constants/app_constants.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:days/features/home/presentation/widgets/about/about_app_information_footer.dart';
import 'package:days/shared/ui/layout/cupertino_sheet_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

const _heartAssets = 'assets/images/icons/illustrations/Heart-9.png';
const _warioddlyImageAssets = 'assets/images/warioddly.png';

class AboutAppInformation extends StatelessWidget {
  const AboutAppInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoSheetWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: Dimensions.large.paddingBottom,
                    child: Image.asset(
                      _heartAssets,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "hey there!\n\ni created 'days' as a daily reminder that life is "
                        'too short to spend doing things I am not excited about this.'
                        "\n\ni hope every time you look at this app you're reminded"
                        '\n\nevery day metters\n\nlove,',
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () => launchUrlString(AppConstants.portfolio),
                    child: Padding(
                        padding: Dimensions.normal.paddingTop,
                        child: BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) {
                            final invertColors = state == ThemeState.dark
                                || state == ThemeState.system
                                && WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                invertColors: invertColors,
                              ),
                              child: Image.asset(
                                _warioddlyImageAssets,
                              ),
                            );
                          },
                        )
                    ),
                  ),
                ],
              ),
            ),
            const AboutAppInformationFooter(),
          ],
        ),
      ),
    );
  }
}
