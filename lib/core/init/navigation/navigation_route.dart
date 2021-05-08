
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sample/core/components/cards/not_found_navigation_widget.dart';
import 'package:flutter_sample/core/constant/navigation/navigation_constants.dart';
import 'package:flutter_sample/screens/screens.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.TEST_VIEW:
        return normalNavigate(LoginScren());
      default:
        return MaterialPageRoute(
          builder: (context) => NotFoundNavigationWidget(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
 }
  