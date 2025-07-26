import 'package:days/core/interfaces/mapper_interface.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';

class GridTypeMapper extends Mapper<String?, GridType> {

  @override
  String mapFrom(GridType output) {
    return output.name;
  }

  @override
  GridType mapTo(String? input) {
    return GridType.values.firstWhere(
      (e) => e.name == input,
      orElse: () => GridType.illustrated,
    );
  }

}