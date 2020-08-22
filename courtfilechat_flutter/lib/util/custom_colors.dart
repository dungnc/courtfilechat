import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color themeColor = hexToColor("#000000");

  static Color whiteColor = Colors.white;

  static Color blueColor = hexToColor("#2EB7FC");
  static Color blackColor = hexToColor("#000000");
  static Color orangeColor = hexToColor("#EB6841");
  static Color grayColor = hexToColor("#CCD5E6");
  static Color grayTextColor = hexToColor("#E0E4CC");
  static Color greenColor = hexToColor("#00A0B0");
  static Color redColor = hexToColor("#ff0000");
  static Color lightBlue = hexToColor("#2096f3");
  static Color grayTextColorDark = const Color(0xff8a8a8a);
  static Color dividerColor=const Color(0xFFBFBFBF);
  static Color lightGrayColor=const Color(0xFFEAE9E4);



}