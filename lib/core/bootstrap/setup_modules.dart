import 'dart:developer';

import 'package:days/core/base/locator_module_interface.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/app/di.dart';
import 'package:days/features/home/di.dart';

Future<void> $setupAppModules() async {

  log('Setting up dependency injection', name: 'DI');

  final modules = <LocatorModule>[AppModule(), HomeModule()];

  await [ for (final module in modules) module.builder(Locator.I) ].wait;

  log('Dependency injection setup complete', name: 'DI');
}
