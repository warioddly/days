import 'package:days/core/base/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/core/services/di_service.dart';
import 'package:days/features/home/data/datasource/settings_datasource/local/settings_local_datasource.dart';
import 'package:days/features/home/data/datasource/settings_datasource/settings_datasource.dart';
import 'package:days/features/home/data/mapper/grid_type_mapper.dart';
import 'package:days/features/home/data/repository/settings_repository_impl.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';
import 'package:days/features/home/presentation/bloc/grid_type_notifier.dart';

class HomeModule extends LocatorModule {
  @override
  Future<void> builder(GetIt getIt) async {
    getIt
      ..registerFactory<GridTypeMapper>(GridTypeMapper.new)
      ..registerFactory<SettingsDataSource>(
        () => SettingsLocalDataSourceImpl(db: getIt.get<LocalStorage>()),
      )
      ..registerFactory<SettingsRepository>(
        () => SettingsRepositoryImpl(
          localDataSource: getIt.get<SettingsDataSource>(),
          gridTypeMapper: getIt.get<GridTypeMapper>(),
        ),
      )
      ..registerFactory(() => GridTypeNotifier(getIt.get()));
  }
}
