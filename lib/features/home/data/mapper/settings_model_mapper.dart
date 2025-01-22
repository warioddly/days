import 'package:days/core/interfaces/mapper_interface.dart';
import 'package:days/features/home/data/model/settings_model.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';

class SettingsModelMapper extends Mapper<SettingsModel, SettingsEntity> {

  @override
  SettingsModel mapFrom(SettingsEntity output) {
    return SettingsModel(
      birthday: output.birthday,
      endDateTime: output.endDateTime,
      gridType: output.gridType,
    );
  }

  @override
  SettingsEntity mapTo(SettingsModel input) {
    return SettingsEntity(
      birthday: input.birthday,
      endDateTime: input.endDateTime,
      gridType: input.gridType,
    );
  }

}