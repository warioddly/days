part of 'settings_bloc.dart';

final class SettingsModelState {

  final SettingsState state;
  final SettingsEntity entity;

  SettingsModelState({
    required this.state,
    required this.entity,
  });

  SettingsModelState.initial() : this(
      state: SettingsInitial(),
      entity: SettingsEntity.initial(),
  );

  SettingsModelState copyWith({
    SettingsState? state,
    SettingsEntity? entity,
  }) {
    return SettingsModelState(
      state: state ?? this.state,
      entity: entity ?? this.entity,
    );
  }
}

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {}

final class SettingsError extends SettingsState {
  final Object message;

  SettingsError(this.message);
}
