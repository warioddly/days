import 'package:days/core/utils/frame_rate_utils.dart';
import 'package:days/features/home/presentation/bloc/dots_manager_notifier.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/dot_grid_body_builder.dart'
    show DotGridBodyBuilder;
import 'package:days/features/home/presentation/pages/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/pages/widgets/tooltip/tooltip.dart'
    show TooltipOverlay;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class DotGridBuilder extends StatefulWidget {
  const DotGridBuilder({super.key});
}

abstract class DotGridState<T extends DotGridBuilder> extends State<T> {
  final framer = Framer();
  final tooltip = TooltipOverlay();

  DotsManagerNotifier get dotManagerModel => DotsManagerNotifier.of(context);

  List<GlobalKey<DotState>> get keys => dotManagerModel.keys;

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return DotGridBodyBuilder(
      now: DateTime.now(),
      onPanUpdate: onPanUpdate,
      itemBuilder: itemBuilder,
      onBuildComplete: onAnimationComplete,
    );
  }

  void onPanUpdate(Offset position);

  Widget itemBuilder(int index, DateTime date, DateTime now);

  GlobalKey<DotState> createAndStoreDotKey() => dotManagerModel.addKey();

  void onAnimationComplete() => dotManagerModel.userHovered();

  void onDotEnable() {
    _vibrate();
    dotManagerModel.incrementActiveDots();
  }

  void onDotDisable() {
    _vibrate();
    dotManagerModel.decrementActiveDots();
  }

  void onOverlapping(GlobalKey<DotState> key, Offset position) {
    final date = key.currentState?.widget.date;
    if (date == null) {
      return;
    }
    tooltip.update(context, position, date);
  }

  void _vibrate() {
    HapticFeedback.lightImpact();
  }

  @override
  void dispose() {
    tooltip.dispose();
    super.dispose();
  }
}
