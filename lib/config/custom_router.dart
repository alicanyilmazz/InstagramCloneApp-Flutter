import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/sample/sample_register.dart';

import '../screens/sample/sample.dart';
import '../screens/screens.dart';
import '../screens/splash/splash_screen.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
        break;
      case SplashScreen.routeName:
        return SplashScreen.route();
        break;
      case LoginScren.routeName:
        return LoginScren.route();
        break;
      case NavScren.routeName:
        return NavScren.route();
        break;
      case SampleScren.routeName:
        return SampleScren.route();
        break;
      case SampleRegisterScren.routeName:
        return SampleRegisterScren.route();
        break;
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
