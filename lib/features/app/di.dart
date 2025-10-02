import 'package:days/core/base/locator_module_interface.dart';
import 'package:days/core/services/local_storage.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/app/data/datasource/theme_datasource/local/theme_local_datasource.dart';
import 'package:days/features/app/data/datasource/theme_datasource/theme_datasource.dart';
import 'package:days/features/app/data/repository/theme_repository_impl.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:days/features/app/presentation/bloc/theme_notifier.dart';

class AppModule extends LocatorModule {
  @override
  Future<void> builder(Locator locator) async {
    locator
      ..registerFactory<LocalStorage>(() => LocalStorage.instance)
      ..registerFactory<ThemeDataSource>(
        () => ThemeLocalDataSourceImpl(db: locator.get()),
      )
      ..registerFactory<ThemeRepository>(
        () => ThemeRepositoryImpl(localDataSource: locator.get()),
      )
      ..registerFactory(() => ThemeNotifier(locator.get()));
  }
}
