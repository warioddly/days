import 'package:days/core/constants/dimensions.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:flutter/material.dart';

class Dot extends StatelessWidget {

  final Vector2 position;
  final DateTime? date;
  final Color? color;
  final bool isBefore;

  const Dot(
    this.position, {
    super.key,
    this.date,
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
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (date != null) {
          print( date?.toIso8601String() ?? '');
        }
      },
      child: SizedBox.square(
        dimension: Dimensions.dotContainerSize,
        child: Center(
          child: Container(
            width: Dimensions.dotSize,
            height: Dimensions.dotSize,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isBefore ? Colors.black12 : Colors.white,
                  blurRadius: 3,
                  spreadRadius: .2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
