import 'package:cygneto/ui/screens/home/home_screen.dart';
import 'package:cygneto/ui/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../login/login_screen.dart';

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 2196 on 7/13/2021
/// Purpose : This is a blank splash widget. it will be launched first when app
/// get started.

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with UtilityMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), redirectToLogin);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Opacity(
          opacity: 0.10009,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              boxShadow: [
                Shadows.secondaryShadow,
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 92, 0, 92),
              child: Container(
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    AppStrings.appName,
                    style: CustomTextStyle.titleTextStyle,
                  ))),
            ),
          ),
        ),
      );

  /// Created by Dev 1051 on 7/15/2021
  /// Modified by Dev 1051 on 7/15/2021
  /// Purpose : This method is used to open login screen from splash screen.
  void redirectToLogin() {
    clearStackAndAddScreen(context, const LoginScreen());
  }
}
