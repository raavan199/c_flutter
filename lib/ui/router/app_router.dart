import 'package:flutter/material.dart';

import '../screens/login/login_screen.dart';
import '../screens/splash/splash_screen.dart';

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 1051 on 7/13/2021
/// Purpose : We will provide a route constants here
class RouteConstants {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String forgotPassword = '/forgotPassword';
}

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 2301 on 10/25/2021
/// Purpose : This is maned router defined to generate route for the name.

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) =>
      MaterialPageRoute(builder: (_) {
        switch (settings.name) {
          case RouteConstants.splashRoute:
            return const SplashScreen();
          case RouteConstants.loginRoute:
            return const LoginScreen();

          default:
            return Center(child: Text('No route defined for $settings.name'));
        }
      });
}
