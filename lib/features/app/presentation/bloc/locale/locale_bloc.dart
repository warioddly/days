import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleInitial()) {
    on<LocaleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
