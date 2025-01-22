
enum GridType {
  days,
  weeks,
  months,
  years,
}

class SettingsEntity {

  final DateTime birthday;
  final DateTime endDateTime;
  final GridType gridType;

  const SettingsEntity({
    required this.birthday,
    required this.endDateTime,
    required this.gridType,
  });

  SettingsEntity.initial() : this(
    birthday: DateTime.now(),
    endDateTime: DateTime.now().add(const Duration(days: 365 * 100)),
    gridType: GridType.months,
  );

  copyWith({
    DateTime? birthday,
    DateTime? endDateTime,
    GridType? gridType,
  }) {
    return SettingsEntity(
      birthday: birthday ?? this.birthday,
      endDateTime: endDateTime ?? this.endDateTime,
      gridType: gridType ?? this.gridType,
    );
  }

}