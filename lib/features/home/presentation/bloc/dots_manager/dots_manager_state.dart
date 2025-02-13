part of 'dots_manager_bloc.dart';


final class DotsManagerModelState {

  final bool mouseHover;
  final int activeDotsCount;
  final DotsManagerState state;

  DotsManagerModelState({
    required this.state,
    this.activeDotsCount = 1,
    this.mouseHover = false,
  });

  DotsManagerModelState.initial() : this(
    state: DotsManagerInitial(),
    activeDotsCount: 1,
    mouseHover: false,
  );

  DotsManagerModelState copyWith({
    DotsManagerState? state,
    int? activeDotsCount,
    bool? mouseHover,
  }) {
    return DotsManagerModelState(
      state: state ?? this.state,
      activeDotsCount: activeDotsCount ?? this.activeDotsCount,
      mouseHover: mouseHover ?? this.mouseHover,
    );
  }
}

@immutable
sealed class DotsManagerState {}

final class DotsManagerInitial extends DotsManagerState {}

final class DotsManagerUserOutsideClicked extends DotsManagerState {}

final class DotsManagerActiveDotsIncrement extends DotsManagerState {}

final class DotsManagerActiveDotsDecrement extends DotsManagerState {}

final class DotsManagerActiveDotsCountReset extends DotsManagerState {}
