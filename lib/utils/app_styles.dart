import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SizedBox smallerSizedBox = SizedBox(height: 1.h);
SizedBox smallSizedBox = SizedBox(height: 2.h);
SizedBox mediumSizedBox = SizedBox(height: 4.h);
SizedBox largeSizedBox = SizedBox(height: 6.h);
SizedBox extraLargeSizedBox = SizedBox(height: 8.h);

paddingAll(double padding) => EdgeInsets.all(padding);
paddingSymmetric({double? horizontal, double? vertical}) =>
    EdgeInsets.symmetric(
        horizontal: horizontal ?? 0.0, vertical: vertical ?? 0.0);

class AppStyles {
  static TextStyle smaller = TextStyle(
      fontSize: 8.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w400);

  static TextStyle extraSmallTextStyle = TextStyle(
      fontSize: 10.sp,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500);
  static TextStyle smallTextStyle =
      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500);
  static TextStyle mediumTextStyle =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
  static TextStyle largeTextStyle =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900);

}
