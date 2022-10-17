import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'services/api/api_service.dart';
import 'services/service_locator.dart';
import 'themes/app_theme.dart';
import 'ui/router/app_router.dart';
import 'ui/screens/splash/splash_screen.dart';

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 1051 on 7/13/2021
/// Purpose : This is a main method of application. it will be called first.
void main() {
  setupLocator();
  runApp(const MyApp());
}

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 1051 on 7/13/2021
/// Purpose : This is a my app here, we have define material
/// app with theme and route.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    locator<ApiService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      onGenerateRoute: locator<AppRouter>().generateRoute,
      home:  const SplashScreen(),
    );
  }
}
