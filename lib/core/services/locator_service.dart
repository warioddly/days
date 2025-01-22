
import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/features/home/di.dart';
import 'package:shared_preferences/shared_preferences.dart';


final Map<Type, dynamic> _getIt = <Type, dynamic>{};

void register<T>(T instance) {
  _getIt[T] = instance;
}

void registerFactory<T>(T Function() factory) {
  _getIt[T] = factory;
}

T $getIt<T>() {
  final instance = _getIt[T];
  return (instance is T ? instance : instance()) as T;
}

Future<void> initDependencyInjection() async {

  final sharedPreferences = await SharedPreferences.getInstance();

  register<DbService>(DbService(sharedPreferences));

  final modules = <LocatorModule>[
    HomeModule(),
  ];

  for (final module in modules) {
    module.builder();
  }

}
