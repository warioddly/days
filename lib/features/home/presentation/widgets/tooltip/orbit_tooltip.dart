
import 'package:days/shared/models/vector2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrbitTooltipNotifier extends ChangeNotifier {

  Vector2? _position;
  String? _text;

  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void show() {
    _isVisible = true;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  void setPosition(Vector2 position) {
    _position = position;
    notifyListeners();
  }

  void setText(String text) {
    _text = text;
    notifyListeners();
  }

}

class OrbitTooltip extends StatelessWidget {
  const OrbitTooltip({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrbitTooltipNotifier>(
      builder: (context, notifier, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
          left: notifier._position?.x ?? 0,
          top: notifier._position?.y ?? 0,
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              opacity: notifier.isVisible ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(notifier._text ?? ''),
              ),
            ),
          ),
        );
      },
    );
  }
}
