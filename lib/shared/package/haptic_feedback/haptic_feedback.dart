library;

export 'package:days/shared/package/haptic_feedback/src/implements/haptic_feedback_facade.dart'
  if (dart.library.io) 'package:days/shared/package/haptic_feedback/src/implements/haptic_feedback_mobile.dart'
  if (dart.library.html) 'package:days/shared/package/haptic_feedback/src/implements/haptic_feedback_web.dart';
