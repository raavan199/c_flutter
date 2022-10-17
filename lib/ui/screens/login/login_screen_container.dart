import 'package:flutter/material.dart';

import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2301 on 11/26/2021
/// Purpose : common container for login module screens
/// used in Login, reset, verification screens
class LoginScreenContainer extends StatelessWidget with UtilityMixin {
  LoginScreenContainer({
    required this.hasBack,
    required this.title,
    required this.child,
    required this.btnText,
    required this.onButtonTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget child;
  final String btnText;
  final VoidCallback onButtonTap;
  bool hasBack;

  double _bubbleSize() => 90;

  @override
  Widget build(BuildContext context) => SafeArea(
        top: false,
        child: GestureDetector(
          onTap: () => hideKeyboard(context),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///title
                  Container(
                    color: AppColors.primary,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90, bottom: 40),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          if (hasBack)
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CustomAppBar.backButton(context),
                            )
                          else
                            Container(),
                          Center(
                            child: Text(
                              title.toUpperCase(),
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: AppFonts.normal,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///main container
                  Expanded(
                    child: Container(
                      color: AppColors.primary,
                      child: Padding(
                        padding: EdgeInsets.only(top: _bubbleSize() / 2),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            ///content
                            Container(
                              decoration: AppStyles.commonContainer,
                              padding: EdgeInsets.only(
                                  top: _bubbleSize() / 2,
                                  bottom: 10,
                                  left: 30,
                                  right: 30),
                              child: child,
                            ),

                            ///logo bubble
                            Positioned(
                              top: -(_bubbleSize() / 2),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      Shadows.greyShadow,
                                    ]),
                                height: _bubbleSize(),
                                width: _bubbleSize(),
                                child: Image.asset(AppAssets.imgLogoMini),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///get started button
                  Container(
                      color: Colors.white,
                      child: appCommonFlatButton(
                          btnTxt: btnText, onPressed: onButtonTap))
                ],
              ),
            ),
          ),
        ),
      );
}
