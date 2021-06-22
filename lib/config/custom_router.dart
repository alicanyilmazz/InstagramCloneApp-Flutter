import 'package:flutter/material.dart';

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
      case SignupScren.routeName:
        return SignupScren.route();
        break;
      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProfileScreen.routeName:
        return ProfileScreen.route(args: settings.arguments);
        break;
      case EditProfileScreen.routeName:
        return EditProfileScreen.route(args: settings.arguments);
        break;
         case CommentsScreen.routeName:
        return CommentsScreen.route(args: settings.arguments);
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
