import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/features/home/di.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencyInjection() async {

  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<DbService>(() => DbService(sharedPreferences));

  final modules = <LocatorModule>[
    HomeModule(),
  ];

  for (final module in modules) {
    module.builder();
  }
}
