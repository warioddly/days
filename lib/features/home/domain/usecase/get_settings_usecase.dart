
import 'package:days/core/interfaces/usecase_interface.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';

class GetSettingsUseCase extends UseCase<SettingsEntity, void> {

  final SettingsRepository repository;

  GetSettingsUseCase({required this.repository});

  @override
  Future<SettingsEntity> call(void params) async {
    return repository.getSettings();
  }

}