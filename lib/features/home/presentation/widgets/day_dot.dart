


import 'package:days/shared/models/vector2.dart';
import 'package:flutter/material.dart';

class DayDot extends StatelessWidget {

  const DayDot(
    this.position, {
    super.key,
    this.date,
    this.color,
    this.isBefore = false,
  });

  final Vector2 position;
  final DateTime? date;
  final Color? color;
  final bool isBefore;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (date != null) {
          print( date?.toIso8601String() ?? '');
        }
      },
      child: Center(
        child: Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
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
    );
  }
}
