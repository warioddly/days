import 'package:days/shared/package/haptic_feedback/src/interface.dart'
    as haptic;
import 'package:vibration/vibration.dart';

class HapticFeedback extends haptic.HapticFeedback {
  HapticFeedback() {
    _initialize();
  }

  bool _initialized = false;
  bool _hasAmplitudeControl = false;
  bool _hasVibrator = false;

  Future<void> _initialize() async {
    _hasVibrator = await Vibration.hasVibrator();
    _hasAmplitudeControl = await Vibration.hasAmplitudeControl();
    _initialized = true;
  }

  @override
  Future<void> soft() async {
    if (!_hasVibrator || !_initialized) {
      return;
    }

    await Vibration.vibrate(duration: 20, amplitude: _hasAmplitudeControl ? 128 : -1);
  }
}
