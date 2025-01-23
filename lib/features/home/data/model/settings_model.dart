import 'package:days/features/home/domain/entity/settings_entity.dart';

class SettingsModel extends SettingsEntity {

  SettingsModel({
    required super.birthday,
    required super.endDateTime,
    required super.gridType,
  });

  SettingsModel.initial() : super.initial();

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      birthday: DateTime.parse(json['birthday']),
      endDateTime: DateTime.parse(json['endDateTime']),
      gridType: GridType.values.firstWhere(
          (e) => e.name == json['gridType'],
          orElse: () => GridType.months,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'birthday': birthday.toIso8601String(),
      'endDateTime': endDateTime.toIso8601String(),
      'gridType': gridType.name,
    };
  }

}