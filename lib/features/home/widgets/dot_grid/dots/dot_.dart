// ignore_for_file: avoid_setters_without_getters

import 'dart:math' as math;

import 'package:days/features/home/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/widgets/dot_grid/dots/illustrated_dot_render_object_widget.dart';
import 'package:flutter/gestures.dart' show PanGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DotGridRenderObjectWidget extends SingleChildRenderObjectWidget {
  const DotGridRenderObjectWidget({
    required DotBuilderRenderObjectWidget child,
    super.key,
  }) : super(child: child);

  @override
  DotGridBuilderRenderBox createRenderObject(BuildContext context) => DotGridBuilderRenderBox();
}

class DotGridBuilderRenderBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  DotGridBuilderRenderBox() {
    _panGestureRecognizer = PanGestureRecognizer(debugOwner: this)
      ..onStart = _handlePanStart
      ..onUpdate = _handlePanUpdate;
  }

  late final PanGestureRecognizer _panGestureRecognizer;

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    if (event is PointerDownEvent) {
      _panGestureRecognizer.addPointer(event);
    }
  }

  void _handlePanStart(DragStartDetails details) {
    _findHitChild(details.localPosition);
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    _findHitChild(details.localPosition);
  }

  void _findHitChild(Offset position) {
    final result = BoxHitTestResult();
    child?.hitTest(result, position: position);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    child?.layout(constraints, parentUsesSize: true);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (child != null) {
      return child!.hitTest(result, position: position);
    }
    return false;
  }
}

abstract class DotBuilderRenderObjectWidget extends MultiChildRenderObjectWidget {
  const DotBuilderRenderObjectWidget({
    required List<DotRenderObjectWidget> children,
    super.key,
  }) : super(children: children);

  @override
  RenderBox createRenderObject(BuildContext context) {
    return DotBuilderRenderObjectBox();
  }
}

class DotBuilderRenderObjectBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>,
        RenderBoxContainerDefaultsMixin<RenderBox, ContainerBoxParentData<RenderBox>> {
  @override
  void paint(PaintingContext context, Offset offset) {
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as DotParentData?;
      context.paintChild(child, offset + (childParentData?.offset ?? Offset.zero));
      child = childParentData?.nextSibling;
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    var itemsCount = 0;
    var counter = firstChild;
    while (counter != null) {
      itemsCount++;
      final childParentData = counter.parentData as DotParentData?;
      counter = childParentData?.nextSibling;
    }

    if (itemsCount == 0) {
      return;
    }

    final aspectRatio = size.width / size.height;
    final itemsPerRow = math.sqrt(itemsCount * aspectRatio).ceil();
    final rowCount = (itemsCount / itemsPerRow).ceil();

    final spacingX = size.width / itemsPerRow;
    final spacingY = size.height / rowCount;

    var child = firstChild;
    var index = 0;

    while (child != null) {
      final childParentData = child.parentData as DotParentData?;

      child.layout(constraints, parentUsesSize: true);

      final row = index ~/ itemsPerRow;
      final col = index % itemsPerRow;

      childParentData?.offset = Offset(
        col * spacingX + spacingX / 2,
        row * spacingY + spacingY / 2,
      );

      child = childParentData?.nextSibling;
      index++;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    var child = lastChild;
    while (child != null) {
      final childParentData = child.parentData as DotParentData?;
      if (childParentData != null) {
        final isHit = result.addWithPaintOffset(
          offset: childParentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            return child!.hitTest(result, position: transformed);
          },
        );
        if (isHit) {
          return true;
        }
      }
      child = childParentData?.previousSibling;
    }
    return false;
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! DotParentData) {
      child.parentData = DotParentData();
    }
  }
}

class DotParentData extends ContainerBoxParentData<RenderBox> {
  int day = 0;
}

abstract class DotRenderObjectWidget extends LeafRenderObjectWidget {
  const DotRenderObjectWidget({super.key});
}

abstract class DotRenderObjectBox extends RenderBox {
  @override
  void performLayout() {
    size = constraints.biggest;
  }
}
