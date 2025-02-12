import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dot_grid_body_builder.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/illustrated_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DotGridBody extends StatefulWidget {
  const DotGridBody({super.key});

  @override
  State<DotGridBody> createState() => _DotGridBodyState();
}

class _DotGridBodyState extends State<DotGridBody> {

  var now = DateTime.now();
  var _lastUpdateTime = Duration.zero;
  final keys = <GlobalKey<DotState>>[];
  final fps = const Duration(milliseconds: 1000 ~/ 120);

  @override
  Widget build(BuildContext context) {
    final entity = context.read<SettingsBloc>().state.entity;
    return BlocListener<DotsManagerBloc, DotsManagerModelState>(
      listener: _listener,
      child: DotGridBodyBuilder(
        now: now,
        throttlePanUpdate: _throttlePanUpdate,
        onPanUpdate: _onPanUpdate,
        itemBuilder: (index, date) =>
            _itemBuilder(index, date, entity.gridType),
      ),
    );
  }

  Widget _itemBuilder(int index, DateTime date, GridType type) {
    late final Widget dot;
    final key = GlobalKey<DotState>();
    keys.add(key);

    if (type.sameWith(now, date)) {
      dot = IllustratedDot.current(
        key: key,
        date: date,
      );
    }
    else if (date.isBefore(now)) {
      dot = IllustratedDot(
        key: key,
        date: date,
        isActive: true,
        color: Colors.red,
      );
    }
    else {
      dot = IllustratedDot(
        key: key,
        date: date,
        isActive: false,
        color: Colors.red,
      );
    }

    return dot;
  }

  void _throttlePanUpdate(Offset globalPosition) {
    _animation1(
      context,
      keys,
      globalPosition,
      () {
        context.read<DotsManagerBloc>().add(DotsManagerUserHoveredEvent());
      },
    );
  }

  void _onPanUpdate(Offset globalPosition) {
    final currentTime = SchedulerBinding.instance.currentSystemFrameTimeStamp;
    if (currentTime - _lastUpdateTime < fps) {
      return;
    }
    _lastUpdateTime = currentTime;
    _throttlePanUpdate(globalPosition);
  }

  void _listener(BuildContext context, DotsManagerModelState state) {

    final eventState = state.state;

    if (eventState is DotsManagerUserOutsideClicked) {

      for (final key in keys) {
        final widget = key.currentState;
        if (widget != null && !widget.widget.isActive) {
          widget.disable();
        }
      }

    }

  }

}

void _animation1(
  BuildContext context,
  List<GlobalKey<DotState>> keys,
  Offset globalPosition,
  VoidCallback onComplete,
) {
  for (final key in keys) {
    final box = key.currentContext?.findRenderObject() as RenderBox?;

    if (box != null) {
      final local = box.globalToLocal(globalPosition);
      final isInside = box.paintBounds.contains(local);

      if (isInside) {
        key.currentState?.enable();
        onComplete();
        break;
      }
    }
  }
}

void _animation2(
  BuildContext context,
  List<GlobalKey<DotState>> keys,
  Offset globalPosition,
  VoidCallback onComplete,
) {

  for (int i = 0; i < keys.length; i++) {
    final key = keys[i];
    final box = key.currentContext?.findRenderObject() as RenderBox?;

    if (box != null) {
      key.currentState?.disable();
    }
  }

  for (int i = 0; i < keys.length; i++) {
    final key = keys[i];
    final box = key.currentContext?.findRenderObject() as RenderBox?;

    if (box != null) {
      final local = box.globalToLocal(globalPosition);
      final isInside = box.paintBounds.contains(local);

      if (isInside) {

        for (int j = 0; j <= i; j++) {
          keys[j].currentState?..disable()..enable();
        }

        onComplete();
        break;

      }
    }
  }

}