import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/shared/ui/widgets/sliding_segment_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, Brightness>(
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
              child: Icon(CupertinoIcons.sun_max_fill),
            ),
            Brightness.dark: Icon(CupertinoIcons.moon_stars_fill),
          },
        );
      },
    );
  }
}
