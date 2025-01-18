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