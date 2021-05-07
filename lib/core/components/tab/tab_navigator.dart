import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/blocs/auth/auth_bloc.dart';
import 'package:flutter_sample/config/custom_router.dart';

import 'package:flutter_sample/core/constant/enums/bottom_navbar_enum.dart';
import 'package:flutter_sample/repositories/user/user_repository.dart';
import 'package:flutter_sample/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter_sample/screens/screens.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders[initialRoute](context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        return FeedScreen();
        break;
      case BottomNavItem.search:
        return SearchScreen();
        break;
      case BottomNavItem.create:
        return CreatePostScreen();
        break;
      case BottomNavItem.notifications:
        return NotificationScreen();
        break;
      case BottomNavItem.profile:
        return BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(
            userRepository: context.read<UserRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(  
              ProfileLoadUser(userId: context.read<AuthBloc>().state.user.uid)),
          child: ProfileScreen(),
        );
        break;
      default:
        return Scaffold();
    }
  }
}
