// ignore_for_file: avoid_setters_without_getters

import 'dart:async';
import 'dart:math' as math;

import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/home/dot_manager.dart';
import 'package:days/features/home/widgets/dot_grid/dot_grid_builder.dart';
import 'package:days/features/home/widgets/tooltip/tooltip_overlay.dart';
import 'package:days/features/home/widgets/tooltip/tooltip_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class DotedDotBuilderRenderObjectWidget extends DotBuilderRenderObjectWidget {
  DotedDotBuilderRenderObjectWidget({super.key}) : super(children: renderChildren());

  static List<DotRenderObjectWidget> renderChildren() {
    final now = DateTime.now();
    final endOfYear = DateTime(now.year).add(const Duration(days: 365));
    final daysInYear = endOfYear.difference(DateTime(now.year)).inDays;
    return List<DotRenderObjectWidget>.generate(
      daysInYear,
      (_) => const DotedDotRenderObjectWidget(),
    );
  }

  @override
  RenderBox createRenderObject(BuildContext context) {
    return DotBuilderRenderObjectBox();
  }
}

class DotedDotRenderObjectWidget extends DotRenderObjectWidget {
  const DotedDotRenderObjectWidget({super.key});

  @override
  RenderBox createRenderObject(BuildContext context) {
    return DotedDotRenderObjectBox(
      activeColor: context.colorScheme.onPrimary,
      dotManager: DotManager.of(context),
      tooltip: TooltipProvider.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, DotedDotRenderObjectBox renderObject) {
    renderObject
      ..activeColor = context.colorScheme.onPrimary
      ..dotManager = DotManager.of(context)
      ..tooltip = TooltipProvider.of(context);
  }
}

class DotedDotRenderObjectBox extends DotRenderObjectBox {
  DotedDotRenderObjectBox({
    required TooltipOverlay tooltip,
    required DotManager dotManager,
    Color? activeColor,
  }) : _tooltip = tooltip,
       _activeColor = activeColor ?? CupertinoColors.activeBlue,
       _dotManager = dotManager;

  late TooltipOverlay _tooltip;
  late DotManager _dotManager;

  set tooltip(TooltipOverlay value) {
    if (_tooltip == value) return;
    _tooltip = value;
  }

  set dotManager(DotManager value) {
    _dotManager = value;
  }

  late Color _activeColor;

  set activeColor(Color value) {
    if (_activeColor == value) return;
    _activeColor = value;
    _activePaint.color = _activeColor;
    markNeedsPaint();
  }

  late final Paint _activePaint = Paint()
    ..color = _activeColor
    ..style = PaintingStyle.fill;

  final Paint _inactivePaint = Paint()
    ..color = CupertinoColors.tertiarySystemFill.darkHighContrastColor
    ..style = PaintingStyle.fill;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (isDefaultActiveDay) {
        markNeedsPaint();
        return;
      }
      _dotManager.increment();
    });
  }

  @override
  void detach() {
    _deactivationTimer?.cancel();
    _tooltip.dispose();
    super.detach();
  }

  @override
  void setActive(bool value) {
    if (value && isActive) {
      _propagateDeactivation();
      return;
    }

    if (isActive == value) return;

    super.setActive(value);
    if (value) {
      _dotManager.decrement();
      _propagateDeactivation();
    } else {
      _dotManager.increment();
      _deactivationTimer?.cancel();
    }
  }

  Timer? _deactivationTimer;

  void _scheduleDeactivation() {
    _deactivationTimer?.cancel();
    _deactivationTimer = Timer(const Duration(seconds: 3), () {
      setActive(false);
      markNeedsPaint();
    });
  }

  void _propagateDeactivation() {
    if (!isDefaultActiveDay) {
      _scheduleDeactivation();
      _propagateDeactivationSchedule();
    }
  }

  void _propagateDeactivationSchedule() {
    final pData = parentData as DotParentData?;
    if (pData == null) return;

    var previous = pData.previousSibling;
    while (previous != null) {
      if (previous is DotedDotRenderObjectBox &&
          previous.isActive &&
          !previous.isDefaultActiveDay) {
        previous._scheduleDeactivation();
        previous = (previous.parentData as DotParentData?)?.previousSibling;
      } else {
        break;
      }
    }

    var next = pData.nextSibling;
    while (next != null) {
      if (next is DotedDotRenderObjectBox && next.isActive && !next.isDefaultActiveDay) {
        next._scheduleDeactivation();
        next = (next.parentData as DotParentData?)?.nextSibling;
      } else {
        break;
      }
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = isActive ? _activePaint : _inactivePaint;
    context.canvas.drawCircle(offset, 3.0, paint);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final distance = position.distance;
    if (distance <= 12.0) {
      setActive(true);
      _updateSiblingStates();
      _showTooltip(position);
      markNeedsPaint();
      return true;
    }

    return false;
  }

  void _updateSiblingStates() {
    final pData = parentData as DotParentData?;
    if (pData == null) return;

    var previousDot = pData.previousSibling;
    while (previousDot != null) {
      if (previousDot is DotRenderObjectBox) {
        if (previousDot.isActive) break;
        previousDot.setActive(true);
      }
      final prevParentData = previousDot.parentData as DotParentData?;
      previousDot = prevParentData?.previousSibling;
    }

    var nextDot = pData.nextSibling;
    while (nextDot != null) {
      if (nextDot is DotRenderObjectBox && nextDot.isActive && !nextDot.isDefaultActiveDay) {
        nextDot.setActive(false);
      }
      final nextParentData = nextDot.parentData as DotParentData?;
      nextDot = nextParentData?.nextSibling;
    }
  }

  void _showTooltip(Offset position) {
    final now = DateTime.now();
    final date = DateTime(now.year).add(Duration(days: dayIndex));
    _tooltip.update(localToGlobal(position), date);
  }
}
