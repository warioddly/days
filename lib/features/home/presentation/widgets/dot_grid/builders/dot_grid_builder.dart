import 'package:days/core/utils/frame_rate_utils.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dot_grid_body_builder.dart' show DotGridBodyBuilder;
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/widgets/tooltip/tooltip_controller.dart';
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

  late final tooltip = context.read<TooltipController>();

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
    dotManagerBloc.add(DotsManagerActiveDotsIncrementEvent());
  }

  void onDotDisable() {
    dotManagerBloc.add(DotsManagerActiveDotsDecrementEvent());
  }

  void onOverlapping(GlobalKey<DotState> key, Offset position) {
    if (key.currentState == null || key.currentState!.widget.date == null) {
      return;
    }
    tooltip
      ..show()
      ..setContent(key.currentState!.widget.date!)
      ..setPosition(position - const Offset(40, 50.0));
  }

}
