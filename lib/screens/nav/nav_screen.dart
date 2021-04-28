import 'package:flutter/material.dart';

class NavScren extends StatelessWidget {
  static const String routeName = '/nav';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => NavScren(), //https://stackoverflow.com/questions/25517016/what-does-it-mean-to-pass-i-e-underscore-as-the-sole-parameter-to-a-dart
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Nav Screen'),
    );
  }
}
