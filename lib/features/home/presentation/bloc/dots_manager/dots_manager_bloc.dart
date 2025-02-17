import 'dart:async';
import 'package:days/core/constants/app_constants.dart';
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
    on<DotsManagerActiveDotsIncrementEvent>(_onActiveDotsIncrement);
    on<DotsManagerActiveDotsDecrementEvent>(_onActiveDotsDecrement);
    on<DotsManagerActiveDotsCountResetEvent>(_onActiveDotsCountReset);
    on<DotsManagerUserHoveredEvent>(_onDeActiveHoveredDotsUpdateResetTimer);
  }

  Timer? _resetHoverActivatedDotsTimer;

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

    if (_resetHoverActivatedDotsTimer != null) {
      _resetHoverActivatedDotsTimer!.cancel();
    }

    _resetHoverActivatedDotsTimer = Timer(
      const Duration(
        milliseconds: AppConstants.deactivateDotDurationInMilliseconds,
      ),
      () => add(DotsManagerUserOutsideClickEvent()),
    );

  }

  void _onActiveDotsIncrement(
      DotsManagerActiveDotsIncrementEvent event,
      Emitter<DotsManagerModelState> emit,
  ) {
    emit(state.copyWith(
      state: DotsManagerActiveDotsIncrement(),
      activeDotsCount: state.activeDotsCount + 1,
    ));
  }

  void _onActiveDotsDecrement(
      DotsManagerActiveDotsDecrementEvent event,
      Emitter<DotsManagerModelState> emit,
  ) {
    emit(state.copyWith(
      state: DotsManagerActiveDotsDecrement(),
      activeDotsCount: state.activeDotsCount - 1,
    ));
  }

  void _onActiveDotsCountReset(
      DotsManagerActiveDotsCountResetEvent event,
      Emitter<DotsManagerModelState> emit,
  ) {
    emit(state.copyWith(
      state: DotsManagerActiveDotsCountReset(),
      activeDotsCount: 0,
    ));
  }

}
