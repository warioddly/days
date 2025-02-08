import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'dots_manager_event.dart';
part 'dots_manager_state.dart';

class DotsManagerBloc extends Bloc<DotsManagerEvent, DotsManagerModelState> {

  DotsManagerBloc() : super(DotsManagerModelState.initial()) {
    _setup();
  }

  void _setup() {
    on<DotsManagerUserOutsideClickEvent>(_onUserOutsideClick);
  }


  void _onUserOutsideClick(
      DotsManagerUserOutsideClickEvent event,
      Emitter<DotsManagerModelState> emit,
  ) {
    emit(state.copyWith(
      state: DotsManagerUserOutsideClicked(),
    ));
  }


}
