import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/features/home/presentation/widgets/dot/dot.dart';
import 'package:days/features/home/presentation/widgets/dot/dot_grid_body_builder.dart';
import 'package:days/features/home/presentation/widgets/dot/illustrated_dot.dart';
import 'package:flutter/cupertino.dart';
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
  var _lastUpdateTime =  Duration.zero;
  final keys = <GlobalKey<DotState>>[];
  final fps = const Duration(milliseconds: 1000 ~/ 16);

  @override
  Widget build(BuildContext context) {
    final entity = context.read<SettingsBloc>().state.entity;
    return DotGridBodyBuilder(
      now: now,
      throttlePanUpdate: _throttlePanUpdate,
      onPanUpdate: _onPanUpdate,
      itemBuilder: (index, date) => _itemBuilder(index, date, entity.gridType),
    );
  }

  Widget _itemBuilder(int index, DateTime date, GridType type) {
    late final Widget dot;
    final key = GlobalKey<IllustratedDotState>();
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
      );
    }
    else {
      dot = IllustratedDot.after(
        key: key,
        date: date,
        isActive: false,
      );
    }

    return dot;
  }

  void _throttlePanUpdate(Offset globalPosition) {
    for (final key in keys) {

      final box = key.currentContext?.findRenderObject() as RenderBox?;

      if (box != null) {
        final local = box.globalToLocal(globalPosition);
        final isInside = box.paintBounds.contains(local);

        if (isInside) {
          key.currentState?.enable();
          break;
        }
      }

    }
  }

  void _onPanUpdate(Offset globalPosition) {
    final currentTime = SchedulerBinding.instance.currentSystemFrameTimeStamp;
    if (currentTime - _lastUpdateTime < fps) {
      return;
    }
    _lastUpdateTime = currentTime;
    _throttlePanUpdate(globalPosition);
  }

}
