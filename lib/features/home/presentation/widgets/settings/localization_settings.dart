import 'package:days/core/constants/dimensions.dart';
import 'package:days/shared/ui/widgets/sliding_segment_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalizationSettings extends StatelessWidget {
  const LocalizationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SlidingSegmentControl<int>(
      groupValue: 1,
      onValueChanged: (int? value) {
        // if (value == null || value == state) {
        //   return;
        // }
        // context.read<ThemeBloc>().add(SetTheme(value));
        if (value == 3) {
          _showOtherLanguages(context);
        }
      },
      children: const {
        1: Padding(
          padding: EdgeInsets.all(Dimensions.small),
          child: Text('English'),
        ),
        2: Text('Russian'),
        3: Text('Other'),
      },
    );
  }

  void _showOtherLanguages(BuildContext context) {
    showCupertinoSheet(
      context: context,
      pageBuilder: (context) {
        return Scaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Dimensions.maxViewWidthSize,
              ),
              child: ListView(children: const [Text('Kyrgyz')]),
            ),
          ),
        );
      },
    );
  }
}
