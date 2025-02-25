part of 'settings_bloc.dart';

sealed class SettingsEvent {}

final class GetSettings extends SettingsEvent {}

final class SetSettings extends SettingsEvent {
  final SettingsEntity entity;

  SetSettings(this.entity);
}