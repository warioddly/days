
import 'package:days/core/interfaces/usecase_interface.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';

class SetSettingsUseCase extends UseCase<SettingsEntity, void> {

  final SettingsRepository repository;

  SetSettingsUseCase({required this.repository});

  @override
  Future<void> call(SettingsEntity params) async {
    repository.setSettings(params);
  }

}