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
       
      case SplashScreen.routeName:
        return SplashScreen.route();
        
      case LoginScren.routeName:
        return LoginScren.route();
        
      case NavScren.routeName:
        return NavScren.route();
        
      case SignupScren.routeName:
        return SignupScren.route();
        
      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProfileScreen.routeName:
        return ProfileScreen.route(args: settings.arguments);
        
      case EditProfileScreen.routeName:
        return EditProfileScreen.route(args: settings.arguments);
        
         case CommentsScreen.routeName:
        return CommentsScreen.route(args: settings.arguments);
        
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
