import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/core/services/di_service.dart';
import 'package:days/features/app/data/datasource/theme_datasource/local/theme_local_datasource.dart';
import 'package:days/features/app/data/datasource/theme_datasource/theme_datasource.dart';
import 'package:days/features/app/data/repository/theme_repository_impl.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:days/features/app/domain/usecase/get_theme_usecase.dart';
import 'package:days/features/app/domain/usecase/set_theme_usecase.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';

class AppModule extends LocatorModule {
  @override
  Future<void> builder(GetIt getIt) async {
    getIt
      ..registerFactory<LocalStorage>(() => LocalStorage.instance)
      ..registerFactory<ThemeDataSource>(
        () => ThemeLocalDataSourceImpl(db: getIt.get<LocalStorage>()),
      )
      ..registerFactory<ThemeRepository>(
        () =>
            ThemeRepositoryImpl(localDataSource: getIt.get<ThemeDataSource>()),
      )
      ..registerFactory(
        () => SetThemeUseCase(repository: getIt.get<ThemeRepository>()),
      )
      ..registerFactory(
        () => GetThemeUseCase(repository: getIt.get<ThemeRepository>()),
      )
      ..registerFactory(
        () => ThemeBloc(
          setThemeUseCase: getIt.get<SetThemeUseCase>(),
          getThemeUseCase: getIt.get<GetThemeUseCase>(),
        ),
      );
  }
}
