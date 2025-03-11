import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/features/app/presentation/di.dart';
import 'package:days/features/home/di.dart';
import 'package:days/shared/package/logger/_logger.dart' show Logger;
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {

  Logger.i('Setting up dependency injection');

  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<DbService>(() => DbService(sharedPreferences));

  final modules = <LocatorModule>[
    AppModule(),
    HomeModule(),
  ];

  for (final module in modules) {
    module.builder();
  }

  Logger.i('Dependency injection setup complete');
}
