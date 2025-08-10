import 'dart:async';

import 'package:days/core/services/di_service.dart';

abstract class LocatorModule {
  FutureOr<void> builder(GetIt getIt);
}
