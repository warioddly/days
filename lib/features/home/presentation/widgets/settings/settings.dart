import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:days/shared/ui/widgets/sliding_segment_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      margin: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .viewInsets
          .bottom),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: Dimensions.maxViewWidthSize,
              ),
              padding: Dimensions.normal.padding,
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
          ),
        ),
      ),
    );
  }
}
