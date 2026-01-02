// ignore_for_file: avoid_setters_without_getters

import 'package:days/features/home/widgets/dot_grid/dots/dot_.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
    return DotedDotRenderObjectBox();
  }
}

class DotedDotRenderObjectBox extends DotRenderObjectBox {
  DotedDotRenderObjectBox();

  static const double dotRadius = 3.0;
  static const double hitTestRadius = 12.0;

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    context.canvas.drawCircle(
      offset,
      dotRadius,
      paint,
    );

    // final textPainter = TextPainter(
    //   text: TextSpan(
    //     text: parentData is DotParentData ? '${(parentData! as DotParentData).day + 1}' : '',
    //     style: const TextStyle(
    //       color: Colors.green,
    //       fontSize: dotRadius * 2,
    //     ),
    //   ),
    //   textDirection: TextDirection.ltr,
    // )..layout();

    // textPainter.paint(
    //   context.canvas,
    //   offset - Offset(textPainter.width / 2, textPainter.height / 2),
    // );
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final distance = position.distance;
    if (distance <= hitTestRadius) {
      HapticFeedback.lightImpact();
      return true;
    }
    return false;
  }
}
