import 'dart:async';

import 'package:days/core/services/di_service.dart';

abstract class LocatorModule {
  Future<void> builder(GetIt getIt);
}
