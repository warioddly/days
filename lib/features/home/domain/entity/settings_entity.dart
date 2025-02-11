
enum GridType {
  days,
  weeks,
  months,
}

class SettingsEntity {

  final GridType gridType;

  const SettingsEntity({
    required this.gridType,
  });

  SettingsEntity.initial() : this(
    gridType: GridType.days,
  );

  SettingsEntity copyWith({GridType? gridType}) {
    return SettingsEntity(
      gridType: gridType ?? this.gridType,
    );
  }

}