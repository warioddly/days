import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/string_extensions.dart';
import 'package:days/features/app/presentation/bloc/locale/locale_bloc.dart';
import 'package:days/features/l10n/_locale.dart';
import 'package:days/features/l10n/generated/day_localizations.dart';
import 'package:days/shared/ui/widgets/sliding_segment_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationSettings extends StatelessWidget {
  const LocalizationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final localeBloc = context.read<LocaleBloc>();
    const supportedLocales = DayLocalizations.supportedLocales;

    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return SlidingSegmentControl<String>(
          groupValue: state.locale.languageCode,
          onValueChanged: (String? value) async {
            if (value == null || value == state.locale.languageCode) {
              return;
            }
            localeBloc.add(LocaleSetEvent(Locale(value)));
          },
          children: _children(supportedLocales),
        );
      },
    );
  }

  Map<String, Widget> _children(List<Locale> supportedLocales) {
    return {
      for (int i = 0; i < supportedLocales.length; i++)
        supportedLocales[i].languageCode: Tooltip(
          message: languageNames[supportedLocales[i].languageCode],
          child: Padding(
            padding: Insets.sm,
            child: Text(supportedLocales[i].languageCode.capitalize),
          ),
        ),
    };
  }
}
