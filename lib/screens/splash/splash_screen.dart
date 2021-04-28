import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/screens/sample/sample.dart';
import 'package:flutter_sample/screens/sample/sample_register.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthhenticated) {
            // Go to the Login Screen.
            // Navigator.of(context).pushNamed(LoginScren.routeName);
            //Navigator.of(context).pushNamed(SampleScren.routeName);
            Navigator.of(context).pushNamed(LoginScren.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            // Go to the  Nav Screen.
            Navigator.of(context).pushNamed(NavScren.routeName);
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
