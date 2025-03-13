import 'package:days/core/utils/frame_rate_utils.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dot_grid_body_builder.dart' show DotGridBodyBuilder;
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/widgets/tooltip/tooltip.dart' show TooltipOverlay;
import 'package:days/shared/package/haptic_feedback/haptic_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class DotKeyManager extends ChangeNotifier {

  final keys = <GlobalKey<DotState>>[];

  void clear() => keys.clear();

}

abstract class DotGridBuilder extends StatefulWidget {
  const DotGridBuilder({super.key});
}

abstract class DotGridState<T extends DotGridBuilder> extends State<T> {

  final framer = Framer();
  final haptic = HapticFeedback();
  final tooltip = TooltipOverlay();

  late final dotKeyManager  = context.read<DotKeyManager>();
  late final dotManagerBloc = context.read<DotsManagerBloc>();

  List<GlobalKey<DotState>> get keys => dotKeyManager.keys;

  @override
  Widget build(BuildContext context) {
    return DotGridBodyBuilder(
      now: DateTime.now(),
      onPanUpdate: onPanUpdate,
      itemBuilder: itemBuilder,
      onBuildComplete: () => onAnimationComplete(context),
    );
  }

  @mustCallSuper
  void onPanUpdate(Offset position);

  Widget itemBuilder(int index, DateTime date, DateTime now);

  GlobalKey<DotState> createAndStoreDotKey() {
    final key = GlobalKey<DotState>();
    dotKeyManager.keys.add(key);
    return key;
  }

  void onAnimationComplete(BuildContext context) {
    dotManagerBloc.add(DotsManagerUserHoveredEvent());
  }

  void onDotEnable() {
    haptic.soft();
    dotManagerBloc.add(DotsManagerActiveDotsIncrementEvent());
  }

  void onDotDisable() {
    haptic.soft();
    dotManagerBloc.add(DotsManagerActiveDotsDecrementEvent());
  }

  void onOverlapping(GlobalKey<DotState> key, Offset position) {
    final date = key.currentState?.widget.date;
    if (date == null) {
      return;
    }
    tooltip.update(context, position, date);
  }

  @mustCallSuper
  @override
  void dispose() {
    tooltip.dispose();
    super.dispose();
  }

}
