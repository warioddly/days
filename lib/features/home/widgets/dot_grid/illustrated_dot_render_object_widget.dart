// ignore_for_file: avoid_setters_without_getters

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/services/image_cache_service.dart';
import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/home/dot_manager.dart';
import 'package:days/features/home/widgets/dot_grid/dot_grid_builder.dart';
import 'package:days/features/home/widgets/tooltip/tooltip_overlay.dart';
import 'package:days/features/home/widgets/tooltip/tooltip_provider.dart';
import 'package:days/shared/ui/animations/ui_curves.dart';
import 'package:days/shared/ui/animations/ui_vsync_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class IllustratedDotBuilderRenderObjectWidget extends DotBuilderRenderObjectWidget {
  IllustratedDotBuilderRenderObjectWidget({super.key}) : super(children: renderChildren());

  static List<DotRenderObjectWidget> renderChildren() {
    final now = DateTime.now();
    final endOfYear = DateTime(now.year).add(const Duration(days: 365));
    final daysInYear = endOfYear.difference(DateTime(now.year)).inDays;
    return List<DotRenderObjectWidget>.generate(
      daysInYear,
      (_) => const IllustratedDotRenderObjectWidget(),
    );
  }
}

class IllustratedDotRenderObjectWidget extends DotRenderObjectWidget {
  const IllustratedDotRenderObjectWidget({super.key});

  @override
  RenderBox createRenderObject(BuildContext context) {
    return IllustratedDotRenderObjectBox(
      activeColor: context.colorScheme.onPrimary,
      tooltip: TooltipProvider.of(context),
      dotManager: DotManager.of(context),
      vsync: UIVsyncProvider.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, IllustratedDotRenderObjectBox renderObject) {
    renderObject
      ..activeColor = context.colorScheme.onPrimary
      ..tooltip = TooltipProvider.of(context)
      ..dotManager = DotManager.of(context)
      ..vsync = UIVsyncProvider.of(context);
  }
}

class IllustratedDotRenderObjectBox extends DotRenderObjectBox {
  IllustratedDotRenderObjectBox({
    required TickerProvider vsync,
    required TooltipOverlay tooltip,
    required DotManager dotManager,
    required Color activeColor,
  }) : _vsync = vsync,
       _tooltip = tooltip,
       _dotManager = dotManager,
       _activeColor = activeColor {
    _animationController = AnimationController(
      vsync: _vsync,
      duration: Durations.medium2,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: UICurves.bounceSwitchAnimation,
    )..addListener(markNeedsPaint);
  }

  TickerProvider _vsync;
  TooltipOverlay _tooltip;
  DotManager _dotManager;

  set vsync(TickerProvider value) {
    if (_vsync == value) return;
    _vsync = value;
    _animationController.resync(_vsync);
  }

  set tooltip(TooltipOverlay value) {
    if (_tooltip == value) return;
    _tooltip = value;
  }

  set dotManager(DotManager value) {
    _dotManager = value;
  }

  Color _activeColor;
  Timer? _deactivationTimer;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  set activeColor(Color value) {
    if (_activeColor == value) return;
    _activeColor = value;
    _activePaint.colorFilter = ColorFilter.mode(
      _activeColor,
      BlendMode.srcIn,
    );
    _inactivePaint.color = _activeColor;
    markNeedsPaint();
  }

  final _randomOffset = Offset(
    math.Random().nextDouble() * 8 - 3,
    math.Random().nextDouble() * 8 - 3,
  );

  final _image = ImageCacheService.getImage(
    IllustrationAssets.getRandomIllustration(),
  );

  late final _activePaint = Paint()
    ..colorFilter = ColorFilter.mode(
      _activeColor,
      BlendMode.srcIn,
    );

  late final _inactivePaint = Paint()
    ..color = _activeColor
    ..style = PaintingStyle.fill;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scheduleInitialAnimation();
  }

  @override
  void detach() {
    _deactivationTimer?.cancel();
    _animationController.dispose();
    _tooltip.dispose();
    super.detach();
  }

  void _scheduleInitialAnimation() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!isDefaultActiveDay) return;

      Future.delayed(Duration(milliseconds: math.Random().nextInt(600)), () {
        if (!attached) return;
        _animationController.forward(from: 0.0);
        _dotManager.increment();
        HapticFeedback.mediumImpact();
      });
    });
  }

  @override
  void setActive(bool value) {
    if (isActive == value) return;

    super.setActive(value);
    if (isActive) {
      _animationController.forward(from: 0);
      _dotManager.increment();
      _scheduleDeactivation(const Duration(seconds: 3));
    } else {
      _animationController.reverse(from: 1.0);
      _dotManager.decrement();
      _deactivationTimer?.cancel();
    }
  }

  void _scheduleDeactivation(Duration duration) {
    _deactivationTimer?.cancel();
    _deactivationTimer = Timer(duration, () => setActive(false));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final newOffset = offset + _randomOffset;

    if (_image case final image? when isActive || _animation.value > 0.0) {
      _paintImage(context, newOffset, image);
    } else {
      context.canvas.drawCircle(offset + _randomOffset, 1.0, _inactivePaint);
    }
  }

  void _paintImage(PaintingContext context, Offset offset, ui.Image image) {
    final imageSize = 18.0 * _animation.value;
    final src = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );
    final dst = Rect.fromCenter(
      center: offset + _randomOffset,
      width: imageSize,
      height: imageSize,
    );

    context.canvas.drawImageRect(image, src, dst, _activePaint);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (position.distance <= 12.0) {
      if (isActive) {
        _showTooltip(position);
      } else {
        setActive(true);
      }
      return true;
    }
    return false;
  }

  void _showTooltip(Offset position) {
    final now = DateTime.now();
    final date = DateTime(now.year).add(Duration(days: dayIndex));
    _tooltip.update(localToGlobal(position), date);
  }
}
