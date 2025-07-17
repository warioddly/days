part of 'settings_bloc.dart';

final class SettingsState {

  final $SettingsState state;
  final SettingsEntity entity;

  SettingsState({
    required this.state,
    required this.entity,
  });

  SettingsState.initial() : this(
      state: SettingsInitial(),
      entity: SettingsEntity.initial(),
  );

  SettingsState copyWith({
    $SettingsState? state,
    SettingsEntity? entity,
  }) {
    return SettingsState(
      state: state ?? this.state,
      entity: entity ?? this.entity,
    );
  }
}

sealed class $SettingsState {}

final class SettingsInitial extends $SettingsState {}

final class SettingsLoading extends $SettingsState {}

final class SettingsLoaded extends $SettingsState {}

final class SettingsError extends $SettingsState {
  final Object error;
  SettingsError(this.error);
}
