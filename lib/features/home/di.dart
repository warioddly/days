import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/core/services/di_service.dart';
import 'package:days/features/home/data/datasource/settings_datasource/local/settings_local_datasource.dart';
import 'package:days/features/home/data/datasource/settings_datasource/settings_datasource.dart';
import 'package:days/features/home/data/mapper/settings_model_mapper.dart';
import 'package:days/features/home/data/repository/settings_repository_impl.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';

class HomeModule extends LocatorModule {
  @override
  void builder(GetIt getIt) {
    getIt
      ..registerFactory<SettingsModelMapper>(SettingsModelMapper.new)
      ..registerFactory<SettingsDataSource>(
        () => SettingsLocalDataSourceImpl(db: getIt.get<LocalStorage>()),
      )
      ..registerFactory<SettingsRepository>(
        () => SettingsRepositoryImpl(
          localDataSource: getIt.get<SettingsDataSource>(),
          settingsModelMapper: getIt.get<SettingsModelMapper>(),
        ),
      )
      ..registerFactory(
        () => SettingsBloc(repository: getIt.get<SettingsRepository>()),
      );
  }
}
