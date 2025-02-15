import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/presentation/widgets/about/about_app_information.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Dimensions.small.padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Dimensions.small,
          children: [
            text(context, 'SETTINGS', () => _onSettingsTap(context)),
            const DefaultDot(size: Dimensions.dotSeparatorSize),
            text(context, 'ABOUT', () => _onAboutTap(context)),
          ],
        ),
      ),
    );
  }

  Widget text(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  void _onSettingsTap(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => const AppSettings() ,
    );
  }

  void _onAboutTap(BuildContext context) {

    // if (!kIsWeb && MediaQueryUtils.getScreenWidth > 800) {
    //   showDialog(
    //     context: context,
    //     useSafeArea: true,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: content,
    //       );
    //     },
    //   );
    //   return;
    // }


    showCupertinoSheet(
      context: context,
      pageBuilder: (_) => const Scaffold(
        body: AboutAppInformation(),
      ),
    );
  }

}
