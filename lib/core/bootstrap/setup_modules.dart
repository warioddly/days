import 'package:days/core/base/locator_module_interface.dart';
import 'package:days/core/services/di_service.dart';
import 'package:days/features/app/di.dart';
import 'package:days/features/home/di.dart';
import 'package:days/shared/package/logger/_logger.dart';

Future<void> $setupAppModules() async {
  Logger.log('Setting up dependency injection', name: 'DI');

  final modules = <LocatorModule>[AppModule(), HomeModule()];

  for (final module in modules) {
    await module.builder(GetIt.I);
  }

  Logger.log('Dependency injection setup complete', name: 'DI');
}
