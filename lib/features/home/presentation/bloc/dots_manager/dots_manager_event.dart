part of 'dots_manager_bloc.dart';

@immutable
sealed class DotsManagerEvent {}

final class DotsManagerUserOutsideClickEvent extends DotsManagerEvent {}

final class DotsManagerUserHoveredEvent extends DotsManagerEvent {}

final class DotsManagerActiveDotsIncrementEvent extends DotsManagerEvent {}

final class DotsManagerActiveDotsDecrementEvent extends DotsManagerEvent {}

final class DotsManagerActiveDotsCountResetEvent extends DotsManagerEvent {}

