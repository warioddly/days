part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class GetSettings extends SettingsEvent {}

final class SetSettings extends SettingsEvent {
  final SettingsEntity entity;

  SetSettings(this.entity);
}