// ignore_for_file: avoid_setters_without_getters

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/services/image_cache_service.dart';
import 'package:days/features/home/widgets/dot_grid/dots/dot_.dart';
import 'package:days/shared/ui/ui_curves.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class VsyncProvider extends StatefulWidget {
  const VsyncProvider({required this.child, super.key});
  final Widget child;

  static TickerProvider of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<_InheritedVsyncProvider>();
    assert(
      provider != null,
      'No VsyncProvider found in context. Make sure to wrap your widget tree with VsyncProvider.',
    );
    return provider!.vsync;
  }

  @override
  State<VsyncProvider> createState() => _VsyncProviderState();
}

class _VsyncProviderState extends State<VsyncProvider> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _InheritedVsyncProvider(
      vsync: this,
      child: widget.child,
    );
  }
}

class _InheritedVsyncProvider extends InheritedWidget {
  const _InheritedVsyncProvider({
    required this.vsync,
    required super.child,
  });

  final TickerProvider vsync;

  @override
  bool updateShouldNotify(_InheritedVsyncProvider oldWidget) {
    return vsync != oldWidget.vsync;
  }
}

class IllustratedDotBuilderRenderObjectWidget extends DotBuilderRenderObjectWidget {
  IllustratedDotBuilderRenderObjectWidget({super.key}) : super(children: renderChildren());

  static List<DotRenderObjectWidget> renderChildren() {
    final now = DateTime.now();
    final endOfYear = DateTime(now.year).add(const Duration(days: 365));
    final daysInYear = endOfYear.difference(DateTime(now.year)).inDays;
    return List<DotRenderObjectWidget>.generate(
      daysInYear,
      (index) => IllustratedDotRenderObjectWidget(dayIndex: index),
    );
  }
}

class IllustratedDotRenderObjectWidget extends DotRenderObjectWidget {
  const IllustratedDotRenderObjectWidget({required this.dayIndex, super.key});

  final int dayIndex;

  @override
  RenderBox createRenderObject(BuildContext context) {
    return IllustratedDotRenderObjectBox(
      dayIndex: dayIndex,
      vsync: VsyncProvider.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, IllustratedDotRenderObjectBox renderObject) {
    renderObject
      ..dayIndex = dayIndex
      ..vsync = VsyncProvider.of(context);
  }
}

class IllustratedDotRenderObjectBox extends DotRenderObjectBox {
  IllustratedDotRenderObjectBox({
    required int dayIndex,
    required TickerProvider vsync,
  }) : _dayIndex = dayIndex,
       _vsync = vsync {
    loadImage();

    _animationController = AnimationController(
      vsync: _vsync,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: UICurves.bounceSwitchAnimation,
    );
    _animation.addListener(markNeedsPaint);

    parentData = DotParentData()..day = dayIndex;
  }

  int _dayIndex;
  int get dayIndex => _dayIndex;
  set dayIndex(int value) {
    if (_dayIndex == value) return;
    _dayIndex = value;
    markNeedsPaint();
  }

  TickerProvider _vsync;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  set vsync(TickerProvider value) {
    if (_vsync == value) return;
    _vsync = value;
    _animationController.resync(_vsync);
  }

  static const double dotRadius = 3.0;
  static const double hitTestRadius = 12.0;

  final _randomOffset = Offset(
    math.Random().nextDouble() * 10 - 5,
    math.Random().nextDouble() * 10 - 5,
  );

  bool _isActive = false;

  set isActive(bool value) {
    if (_isActive != value) {
      _isActive = value;
      HapticFeedback.lightImpact();
      if (_isActive) {
        _animationController.forward(from: 0);
        _scheduleDeactivation(const Duration(seconds: 3));
        markNeedsPaint();
      } else {
        _animationController.reverse(from: 1.0);
        _deactivationTimer?.cancel();
      }
    }
  }

  Timer? _deactivationTimer;

  void _scheduleDeactivation(Duration duration) {
    _deactivationTimer?.cancel();
    _deactivationTimer = Timer(duration, () {
      isActive = false;
    });
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    final now = DateTime.now();
    final dotDate = DateTime(now.year).add(Duration(days: dayIndex));
    if (DateUtils.isSameDay(now, dotDate) || dotDate.isBefore(now)) {
      _isActive = true;
      _animationController.forward(from: 0.0);
    }
  }

  ui.Image? _image;

  void loadImage() {
    if (_image != null) return;
    _image = ImageCacheService.getImage(IllustrationAssets.getRandomIllustration());
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_image case final image? when _isActive || _animation.value > 0.0) {
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

      context.canvas.drawImageRect(
        image,
        src,
        dst,
        Paint()
          ..colorFilter = const ColorFilter.mode(
            Colors.blue,
            BlendMode.srcIn,
          ),
      );
    } else {
      final paint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill;

      context.canvas.drawCircle(
        offset,
        dotRadius,
        paint,
      );
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void detach() {
    _deactivationTimer?.cancel();
    _animationController.dispose();
    super.detach();
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final distance = position.distance;
    if (distance <= hitTestRadius && !_isActive) {
      isActive = true;
      return true;
    }
    return false;
  }
}
