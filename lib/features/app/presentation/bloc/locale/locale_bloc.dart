import 'package:days/features/app/domain/usecase/get_locale_usecase.dart';
import 'package:days/features/app/domain/usecase/set_locale_usecase.dart';
import 'package:days/features/l10n/_locale.dart';
import 'package:flutter/cupertino.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final GetLocaleUseCase getLocaleUseCase;
  final SetLocaleUseCase setLocaleUseCase;

  LocaleBloc({required this.getLocaleUseCase, required this.setLocaleUseCase})
    : super(LocaleState.initial()) {
    on<LocaleSetEvent>(_setLocale);
    on<LocaleSetInitialEvent>(_setInitialLocale);
  }

  Future<void> _setLocale(LocaleSetEvent event, Emitter<LocaleState> emit) async {
    emit(LocaleState(locale: event.locale));
    await setLocaleUseCase(event.locale);
  }

  Future<void> _setInitialLocale(
    LocaleSetInitialEvent event,
    Emitter<LocaleState> emit,
  ) async {
    final locale = await getLocaleUseCase(null);

    if (locale != null) {
      emit(LocaleState(locale: locale));
    } else {
      emit(LocaleState(locale: event.locale));
      await setLocaleUseCase(event.locale);
    }
  }
}
