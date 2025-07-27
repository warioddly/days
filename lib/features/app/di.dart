import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/core/services/di_service.dart';
import 'package:days/features/app/data/datasource/theme_datasource/local/theme_local_datasource.dart';
import 'package:days/features/app/data/datasource/theme_datasource/theme_datasource.dart';
import 'package:days/features/app/data/repository/theme_repository_impl.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:days/features/app/presentation/bloc/theme_notifier.dart';

class AppModule extends LocatorModule {
  @override
  Future<void> builder(GetIt getIt) async {
    getIt
      ..registerFactory<LocalStorage>(() => LocalStorage.instance)
      ..registerFactory<ThemeDataSource>(
        () => ThemeLocalDataSourceImpl(db: getIt.get()),
      )
      ..registerFactory<ThemeRepository>(
        () => ThemeRepositoryImpl(localDataSource: getIt.get()),
      )
      ..registerFactory(() => ThemeNotifier(getIt.get()));
  }
}
