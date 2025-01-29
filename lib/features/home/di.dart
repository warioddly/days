import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/home/data/datasource/settings_datasource/local/settings_local_datasource.dart';
import 'package:days/features/home/data/datasource/settings_datasource/settings_datasource.dart';
import 'package:days/features/home/data/mapper/settings_model_mapper.dart';
import 'package:days/features/home/data/repository/settings_repository_impl.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';
import 'package:days/features/home/domain/usecase/get_settings_usecase.dart';
import 'package:days/features/home/domain/usecase/set_settings_usecase.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';

class HomeModule extends LocatorModule {
  @override
  void builder() {
    getIt.registerFactory<SettingsModelMapper>(() => SettingsModelMapper());

    getIt.registerFactory<SettingsDataSource>(
      () => SettingsLocalDataSourceImpl(
        db: getIt<DbService>(),
      ),
    );

    getIt.registerFactory<SettingsRepository>(
      () => SettingsRepositoryImpl(
        localDataSource: getIt<SettingsDataSource>(),
        settingsModelMapper: getIt<SettingsModelMapper>(),
      ),
    );

    getIt.registerFactory(
      () => SetSettingsUseCase(
        repository: getIt<SettingsRepository>(),
      ),
    );

    getIt.registerFactory(
      () => GetSettingsUseCase(
        repository: getIt<SettingsRepository>(),
      ),
    );

    getIt.registerFactory(
      () => SettingsBloc(
        setSettingsUseCase: getIt<SetSettingsUseCase>(),
        getSettingsUseCase: getIt<GetSettingsUseCase>(),
      ),
    );
  }
}
