import 'dart:async';
import 'package:days/core/services/locator_service.dart';

abstract class LocatorModule {
  Future<void> builder(Locator locator);
}
