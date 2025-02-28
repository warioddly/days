import 'package:days/shared/package/haptic_feedback/src/interface.dart' as haptic;

class HapticFeedback extends haptic.HapticFeedback {

  @override
  Future<void> soft() async {
      throw UnimplementedError('HapticFeedback.soft() is not implemented');
  }

}