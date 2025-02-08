part of 'dots_manager_bloc.dart';


final class DotsManagerModelState {

  final bool mouseHover;
  final DotsManagerState state;

  DotsManagerModelState({
    required this.state,
    this.mouseHover = false,
  });

  DotsManagerModelState.initial() : this(
    state: DotsManagerInitial(),
    mouseHover: false,
  );

  DotsManagerModelState copyWith({
    DotsManagerState? state,
    bool? mouseHover,
  }) {
    return DotsManagerModelState(
      state: state ?? this.state,
      mouseHover: mouseHover ?? this.mouseHover,
    );
  }
}

@immutable
sealed class DotsManagerState {}

final class DotsManagerInitial extends DotsManagerState {}

final class DotsManagerUserOutsideClicked extends DotsManagerState {}
