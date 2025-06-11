import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/app/data/datasource/locale_datasource/local/locale_local_datasource.dart';
import 'package:days/features/app/data/datasource/locale_datasource/locale_datasource.dart';
import 'package:days/features/app/data/datasource/theme_datasource/local/theme_local_datasource.dart';
import 'package:days/features/app/data/datasource/theme_datasource/theme_datasource.dart';
import 'package:days/features/app/data/repository/locale_repository_impl.dart';
import 'package:days/features/app/data/repository/theme_repository_impl.dart';
import 'package:days/features/app/domain/repository/locale_repository.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:days/features/app/domain/usecase/get_locale_usecase.dart';
import 'package:days/features/app/domain/usecase/get_theme_usecase.dart';
import 'package:days/features/app/domain/usecase/set_locale_usecase.dart';
import 'package:days/features/app/domain/usecase/set_theme_usecase.dart';
import 'package:days/features/app/presentation/bloc/locale/locale_bloc.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

class AppModule extends LocatorModule {
  @override
  Future<void> builder() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt
      ..registerLazySingleton<DbService>(() => DbService(sharedPreferences))
      ..registerFactory<ThemeDataSource>(() => ThemeLocalDataSourceImpl(db: getIt<DbService>()))
      ..registerFactory<ThemeRepository>(
        () => ThemeRepositoryImpl(localDataSource: getIt<ThemeDataSource>()),
      )
      ..registerFactory(() => SetThemeUseCase(repository: getIt<ThemeRepository>()))
      ..registerFactory(() => GetThemeUseCase(repository: getIt<ThemeRepository>()))
      ..registerFactory(
        () => ThemeBloc(
          setThemeUseCase: getIt<SetThemeUseCase>(),
          getThemeUseCase: getIt<GetThemeUseCase>(),
        ),
      )
      ..registerFactory<LocaleDataSource>(() => LocaleLocalDataSourceImpl(db: getIt<DbService>()))
      ..registerFactory<LocaleRepository>(
        () => LocaleRepositoryImpl(localDataSource: getIt<LocaleDataSource>()),
      )
      ..registerFactory(() => SetLocaleUseCase(repository: getIt<LocaleRepository>()))
      ..registerFactory(() => GetLocaleUseCase(repository: getIt<LocaleRepository>()))
      ..registerFactory(
        () => LocaleBloc(
          setLocaleUseCase: getIt<SetLocaleUseCase>(),
          getLocaleUseCase: getIt<GetLocaleUseCase>(),
        ),
      );
  }
}
