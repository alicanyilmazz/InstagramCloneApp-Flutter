import 'package:flutter/material.dart';

class TextThemeDark {
  static TextThemeDark? _instace;
  static TextThemeDark? get instance {
    if (_instace == null) _instace = TextThemeDark._init();
    return _instace;
  }

  TextThemeDark._init();

  final TextStyle headline1 =
      TextStyle(fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5);
  final TextStyle headline2 =
      TextStyle(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5);
  final TextStyle headline3 =
      TextStyle(fontSize: 48, fontWeight: FontWeight.w400);
  final TextStyle headline4 =
      TextStyle(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25);
  final TextStyle headline5 =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w400);
  final TextStyle overline =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5);

  final TextStyle coloredTextsilver = TextStyle(
      color: Color(0xFFb3b3b3),
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5);
  final TextStyle coloredTextgold = TextStyle(
      color: Color(0xFFeee8aa),
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5);
  final TextStyle coloredTextplatinium = TextStyle(
      color: Color(0xFFe6e6e6),
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5);
  final TextStyle coloredTextRose = TextStyle(
      color: Color(0xFFb10058),
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5);
  final TextStyle coloredTextmomentum = TextStyle(
      color: Color(0xFF9a9a9a),
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5);
}
