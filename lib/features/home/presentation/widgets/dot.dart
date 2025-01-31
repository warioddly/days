import 'package:days/core/constants/dimensions.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:flutter/material.dart';

class Dot extends StatefulWidget {
  final int? index;
  final Vector2 position;
  final DateTime? date;
  final DateTime? now;
  final Color? color;
  final bool isBefore;

  const Dot(
    this.position, {
    this.index,
    super.key,
    this.date,
    this.now,
    this.color,
    this.isBefore = false,
  });

  const Dot.before(
    Vector2 position, {
    Key? key,
    DateTime? date,
    bool isBefore = false,
  }) : this(
          position,
          date: date,
          color: Colors.white12,
          isBefore: isBefore,
          key: key,
        );

  const Dot.after(
    Vector2 position, {
    Key? key,
    DateTime? date,
    bool isBefore = false,
  }) : this(
          position,
          date: date,
          color: Colors.white,
          isBefore: isBefore,
          key: key,
        );

  @override
  State<Dot> createState() => _DotState();
}

class _DotState extends State<Dot> with SingleTickerProviderStateMixin {

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerHover: (details) {

        if (widget.date != null) {
          print(widget.date?.toIso8601String() ?? '');
        }

        if (_controller.isAnimating) {
          return;
        }

        _controller.forward().then((value) => _controller.reverse());

      },
      child: SizedBox.square(
        dimension: Dimensions.dotContainerSize,
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final value = _controller.value;
              final scale = 1 - value;
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Container(
              width: Dimensions.dotSize,
              height: Dimensions.dotSize,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    spreadRadius: .2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
