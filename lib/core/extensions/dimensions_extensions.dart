import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show EdgeInsets;

extension PaddingExtension on double {
  
  EdgeInsets get padding => EdgeInsets.all(this);
  
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: this);
  
  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: this);
  
  EdgeInsets get paddingTop => EdgeInsets.only(top: this);
  
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: this);
  
  EdgeInsets get paddingLeft => EdgeInsets.only(left: this);
  
  EdgeInsets get paddingRight => EdgeInsets.only(right: this);
  
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