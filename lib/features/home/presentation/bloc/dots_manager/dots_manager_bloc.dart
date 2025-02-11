import 'dart:async';
import 'dart:ui';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
    on<DotsManagerUserHoveredEvent>(
        _onDeActiveHoveredDotsUpdateResetTimer,
    );
    on<DotsManagerUserHoverEvent>(
        _onUserHoverEvent,
      transformer: droppable()
    );
  }

  Timer? _resetHoverActiveDotsTimer;

  void _onUserOutsideClick(
      DotsManagerUserOutsideClickEvent event,
      Emitter<DotsManagerModelState> emit,
  ) {
    emit(state.copyWith(
      state: DotsManagerUserOutsideClicked(),
    ));
  }


  void _onDeActiveHoveredDotsUpdateResetTimer(
      DotsManagerUserHoveredEvent event,
      Emitter<DotsManagerModelState> emit,
  ) {

    if (_resetHoverActiveDotsTimer != null) {
      _resetHoverActiveDotsTimer!.cancel();
    }

    _resetHoverActiveDotsTimer = Timer(const Duration(seconds: 3), () {
      add(DotsManagerUserOutsideClickEvent());
    });

  }


  void _onUserHoverEvent(
      DotsManagerUserHoverEvent event,
      Emitter<DotsManagerModelState> emit,
  ) {
    emit(state.copyWith(
      state: DotsManagerUserHovered(event.position),
    ));
  }


}
