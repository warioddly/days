import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/features/home/presentation/widgets/settings/related_links.dart';
import 'package:days/shared/ui/widgets/sliding_segment_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.15,
          maxWidth: Dimensions.maxViewWidthSize,
        ),
        child: Scaffold(
          body: Padding(
            padding: Dimensions.normal.padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: Dimensions.large.padding.copyWith(
                    top: Dimensions.empty,
                  ),
                  child: BlocBuilder<ThemeBloc, Brightness>(
                    builder: (context, state) {
                      return SlidingSegmentControl<Brightness>(
                        groupValue: state,
                        onValueChanged: (Brightness? value) {
                          if (value == null || value == state) {
                            return;
                          }
                          context.read<ThemeBloc>().add(SetTheme(value));
                        },
                        children: const {
                          Brightness.light: Padding(
                            padding: EdgeInsets.all(Dimensions.small),
                            child: Icon(
                              CupertinoIcons.sun_max_fill,
                            ),
                          ),
                          Brightness.dark: Icon(
                            CupertinoIcons.moon_stars_fill,
                          ),
                        },
                      );
                    },
                  ),
                ),
                const RelatedLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
