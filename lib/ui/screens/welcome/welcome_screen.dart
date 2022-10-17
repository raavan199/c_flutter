import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../exports/resources.dart';
import '../login/login_screen.dart';

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2301 on 11/26/2021
/// Purpose : welcome screen comes when user first installs the app
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ///Cygnet logo
          Padding(
            padding:
                const EdgeInsets.only(top: 80, bottom: 10, left: 50, right: 50),
            child: SvgPicture.asset(
              AppAssets.icLogoLarge
            ),
          ),

          ///welcome image
          Expanded(
            child: Image.asset(AppAssets.imgWelcome),
          ),

          ///welcome content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 10, left: 37, right: 37),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    AppStrings.welcomeTitle,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: AppFonts.normal,
                        fontSize: 28),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    AppStrings.welcomeContent,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: AppFonts.normal,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          ///get started button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _btnGetStarted(),
            ],
          )
        ],
      ));

  /// Created by Dev 2301 on 11/26/2021
  /// Modified by Dev 2301 on 11/26/2021
  /// Purpose : get started button view
  Widget _btnGetStarted() => InkWell(
        onTap: _onClickGetStarted,
        child: Container(
          height: AppStyles.primaryButtonHeight,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppStyles.commonCornerRadius)),
          ),
          width: (MediaQuery.of(context).size.width / 2) - 25,
          child: const Center(
            child: Text(
              AppStrings.lblGetStarted,
              style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: AppFonts.bold,
                  fontSize: 16),
            ),
          ),
        ),
      );

  /// Created by Dev 2301 on 11/26/2021
  /// Modified by Dev 2301 on 11/26/2021
  /// Purpose : click method for get started button view
  void _onClickGetStarted() {
    //redirect to login
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
