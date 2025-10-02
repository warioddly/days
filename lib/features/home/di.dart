import 'package:days/core/base/locator_module_interface.dart';
import 'package:days/core/services/local_storage.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/home/data/datasource/settings_datasource/local/settings_local_datasource.dart';
import 'package:days/features/home/data/datasource/settings_datasource/settings_datasource.dart';
import 'package:days/features/home/data/mapper/grid_type_mapper.dart';
import 'package:days/features/home/data/repository/settings_repository_impl.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';
import 'package:days/features/home/presentation/bloc/grid_type_notifier.dart';

class HomeModule extends LocatorModule {
  @override
  Future<void> builder(Locator locator) async {
    locator
      ..registerFactory<GridTypeMapper>(GridTypeMapper.new)
      ..registerFactory<SettingsDataSource>(
        () => SettingsLocalDataSourceImpl(db: locator.get<LocalStorage>()),
      )
      ..registerFactory<SettingsRepository>(
        () => SettingsRepositoryImpl(
          localDataSource: locator.get<SettingsDataSource>(),
          gridTypeMapper: locator.get<GridTypeMapper>(),
        ),
      )
      ..registerFactory(() => GridTypeNotifier(locator.get()));
  }
}
