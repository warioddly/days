import 'package:flutter/cupertino.dart';

extension StringExtensions on String {

  String get capitalize {
    return length > 1 ? '${this[0].toUpperCase()}${substring(1)}' : this;
  }

}

extension BorderExtension on double {
  BorderRadius get allBorder => BorderRadius.circular(this);

  BorderRadius get bottomBorder => BorderRadius.only(
        bottomLeft: Radius.circular(this),
        bottomRight: Radius.circular(this),
      );

  BorderRadius get topBorder => BorderRadius.only(
        topLeft: Radius.circular(this),
        topRight: Radius.circular(this),
      );
}

extension SizedBoxExtension on double {
  SizedBox get verticalBox => SizedBox(height: this);

  SizedBox get horizontalBox => SizedBox(width: this);

  SizedBox get squareBox => SizedBox.square(dimension: this);
}
