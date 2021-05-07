import 'package:flutter/material.dart';

class ColorSchemeDark {
  static ColorSchemeDark _instace;
  static ColorSchemeDark get instance {
    if (_instace == null) _instace = ColorSchemeDark._init();
    return _instace;
  }

  ColorSchemeDark._init();

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
  final Color modernDark = Color(0xFF26242e);
  final Color classicDark = Color(0xFF333333);
  final Color highRatingRed = Colors.red.shade900;
  final Color cardDarkColor = Color(0xff676870);
  final Color xx = Color(0xFF7c7b7e);
  final Color x2x = Color(0xFF35303f);
  final Color x1x = Color(0xFF7c7b7e);
  final Color tgo = Color(0xFf34323d);
}
