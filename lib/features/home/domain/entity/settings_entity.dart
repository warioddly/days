
enum GridType {
  illustrated,
  doted,
}

class SettingsEntity {

  final GridType gridType;

  const SettingsEntity({
    required this.gridType,
  });

  SettingsEntity.initial() : this(
    gridType: GridType.illustrated,
  );

  SettingsEntity copyWith({GridType? gridType}) {
    return SettingsEntity(
      gridType: gridType ?? this.gridType,
    );
  }

}