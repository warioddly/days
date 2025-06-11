import 'package:days/core/interfaces/locator_module_interface.dart';
import 'package:days/features/app/di.dart';
import 'package:days/features/home/di.dart';
import 'package:days/shared/package/logger/_logger.dart' show Logger;
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {

  Logger.i('Setting up dependency injection');

  final modules = <LocatorModule>[
    AppModule(),
    HomeModule(),
  ];

  for (final module in modules) {
    await module.builder();
  }

  Logger.i('Dependency injection setup complete');
}
