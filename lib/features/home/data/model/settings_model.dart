import 'package:days/features/home/domain/entity/settings_entity.dart';

class SettingsModel extends SettingsEntity {

  SettingsModel({
    required super.gridType,
  });

  SettingsModel.initial() : super.initial();

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      gridType: GridType.values.firstWhere(
          (e) => e.name == json['gridType'],
          orElse: () => GridType.illustrated,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gridType': gridType.name,
    };
  }

}