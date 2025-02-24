import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class OrbitTooltipNotifier extends ChangeNotifier {

  Offset _position = Offset.zero;
  String _content = DateTime.now().toIso8601String();

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

  void setPosition(Offset position) {
    _position = position;
    notifyListeners();
  }

  void setContent(String content) {
    _content = content;
    notifyListeners();
  }
}

class OrbitTooltip extends StatelessWidget {
  const OrbitTooltip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<OrbitTooltipNotifier>(
      builder: (context, notifier, child) {

        final content = DateTimeUtils.format(
          DateTime.parse(notifier._content),
        );

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
          left: notifier._position.dx,
          top: notifier._position.dy,
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              opacity: notifier.isVisible ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.small,
                  vertical: Dimensions.half,
                ),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: Dimensions.small.allBorder,
                  border: Border.all(
                    color: theme.colorScheme.onPrimary,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onPrimary.withAlpha(70),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  content,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
