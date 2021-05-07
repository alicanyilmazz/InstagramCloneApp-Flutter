import 'package:flutter/material.dart';

class ColorSchemeLight {
  static ColorSchemeLight _instace;
  static ColorSchemeLight get instance {
    if (_instace == null) _instace = ColorSchemeLight._init();
    return _instace;
  }

  ColorSchemeLight._init();

  final Color brown = Color(0xffa87e6f);
  final Color red = Color(0xffc10e0e);
  final Color white = Color(0xffffffff);
  final Color gray = Color(0xffa5a6ae);
  final Color lightGray = Color(0xfff7f7f7);
  final Color darkGray = Color(0xff676870);
  final Color black = Color(0xff020306);
  final Color azure = Color(0xff27928d);

  final Color palegoldenroad = Color(0xffeee8aa);
  final Color balm = Color(0xffeed7aa);
  final Color palevioletred = Color(0xffdb7093);
  final Color papayawhip = Color(0xffffefd5);
  final Color whitewash = Color(0xffffd289);
  final Color mediumRatingGray = Color(0xff676870);
  final Color lowRatingGray = Color(0xFF7c7b7e);
  final Color highRatingGray = Color(0xFF26242e);
  final Color highRatingRed = Colors.red.shade900;
  final Color gold = Color(0xffe6c380);

  final Color inputErrorColor = Colors.red;
  final Color inputFocusedErrorColor = Colors.pink.shade900;
  final Color inputDefaultColor = Color(0xffeee8aa);
  final Color inputFocusedColor = Color(0xffa5682a);
  final Color inputHintColor = Colors.white;
  final Color inputErrorTextColor = Color(0xff8b0000);
}
