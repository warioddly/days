import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:days/features/home/presentation/widgets/settings/related_links.dart';
import 'package:days/shared/ui/widgets/sliding_segment_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.2,
        maxWidth: Dimensions.maxViewWidthSize,
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: Dimensions.large.padding,
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return SlidingSegmentControl<ThemeState>(
                    groupValue: state,
                    onValueChanged: (ThemeState? value) {
                      if (value == null || value == state) {
                        return;
                      }
                        context.read<ThemeBloc>().add(SetTheme(value));
                    },
                    children: const {
                      ThemeState.system: Padding(
                        padding: EdgeInsets.all(Dimensions.small),
                        child: Icon(
                          CupertinoIcons.app,
                        ),
                      ),
                      ThemeState.light: Icon(
                        CupertinoIcons.sun_max_fill,
                      ),
                      ThemeState.dark: Icon(
                        CupertinoIcons.moon_stars_fill,
                      ),
                    },
                  );
                },
              ),
            ),
            const RelatedLinks(),
            Dimensions.small.verticalBox,
          ],
        ),
      ),
    );
  }
}
