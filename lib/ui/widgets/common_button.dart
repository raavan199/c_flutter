import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/shadow.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_styles.dart';

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2301 on 11/26/2021
/// Purpose : flat button used throughout the application
Widget appCommonFlatButton({
  required String btnTxt,
  required VoidCallback onPressed,
  bool isButtonEnabled = true,
  bool isLight = false,
  bool isTopLeftRounded = true,
  bool isTopRightRounded = true,
  Color? color,
}) =>
    MaterialButton(
        height: 50,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isTopLeftRounded ? 50 : 0),
              topRight: Radius.circular(isTopRightRounded ? 50 : 0)),
        ),
        elevation: 0,
        splashColor: Platform.isIOS ? Colors.transparent : Colors.white10,
        highlightColor: Colors.transparent,
        color: isButtonEnabled
            ? (isLight ? AppColors.white : (color ?? AppColors.primary))
            : AppColors.hint,
        onPressed: isButtonEnabled ? onPressed : null,
        disabledColor: AppColors.hint,
        child: Center(
          child: Text(
            btnTxt.toUpperCase(),
            style: TextStyle(
              color: isLight ? AppColors.secondary : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ));

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2301 on 11/26/2021
/// Purpose : rounded button used throughout the application
Widget appCommonRoundedButton({
  required String btnTxt,
  required VoidCallback onPressed,
  bool isButtonEnabled = true,
}) =>
    Container(
      decoration: BoxDecoration(
        boxShadow: const [Shadows.greyShadow],
        borderRadius: BorderRadius.circular(30),
      ),
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          height: 38,
          // disabledElevation: 0,
          elevation: 2,
          splashColor: Platform.isIOS ? Colors.transparent : Colors.white10,
          //highlightColor: Colors.transparent,
          color: isButtonEnabled ? AppColors.primary : AppColors.disabled,
          onPressed: isButtonEnabled ? onPressed : null,
          disabledColor: AppColors.disabled,
          child: Text(
            btnTxt,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: AppFonts.bold,
            ),
          )),
    );

/// Created by Dev 1051 on 8/6/2021
/// Modified by Dev 1051 on 8/6/2021
/// Purpose : This is used to provide normal button.
Widget appNormalButton(
        {required Function onPress,
        required String buttonTitle,
        required bool isEnabled,
        Color? backgroundColor,
        TextStyle? textStyle,
        Color? textColor,
        double? height}) =>
    ElevatedButton(
      onPressed: () {
        onPress();
      },
      style: ButtonStyle(
        minimumSize:
            MaterialStateProperty.all(Size(double.infinity, height ?? 45)),
        textStyle: MaterialStateProperty.all(
            textStyle ?? CustomTextStyle.buttonTextStyle),
        backgroundColor: isEnabled
            ? MaterialStateProperty.all(backgroundColor ?? AppColors.hint)
            : MaterialStateProperty.all(AppColors.hint),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(AppColors.white),
      ),
      child: Text(
        buttonTitle,
        style: TextStyle(color: textColor ?? AppColors.white),
      ),
    );

/// Created by Dev 1051 on 8/6/2021
/// Modified by Dev 1051 on 8/6/2021
/// Purpose : This is a app border button which will be used to show border
/// button.
Widget appBorderButton(
        {required Function onPress,
        required String buttonTitle,
        required bool isEnabled,
        double? borderRadius,
        double? borderWidth,
        TextStyle? textStyle,
        Color? borderColor,
        Color? textColor,
        double? height}) =>
    ElevatedButton(
      onPressed: () {
        onPress();
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 45)),
        textStyle: MaterialStateProperty.all(
            textStyle ?? CustomTextStyle.buttonTextStyle),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 3)),
            side: BorderSide(
                color:
                    isEnabled ? borderColor ?? AppColors.black : AppColors.hint,
                width: borderWidth ?? 1))),
        backgroundColor: MaterialStateProperty.all(AppColors.transparent),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(AppColors.white),
      ),
      child: Text(
        buttonTitle,
        style: TextStyle(color: textColor ?? AppColors.black),
      ),
    );
///common bottom button
Widget CommonBottomButton({required String btnText1,required String btnText2,
  required VoidCallback onPress1,required VoidCallback onPrese2})=> Row(
  children: [
    Expanded(
      child: GestureDetector(
        onTap:onPress1,
        child: Container(
          height: AppStyles.primaryButtonHeight,
          padding: EdgeInsets.all(0),
          width:Get.width*.50,
          decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
              )
          ),
          child: Center(
            child: Text(
              btnText1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: AppFonts.normal,
              ),
            ),
          ),
        ),
      ),
    ),
    Container(
      width: 1,
      color: Colors.white,
    ),
    Expanded(
      child: GestureDetector(
        onTap: onPrese2,
        child: Container(
          height: AppStyles.primaryButtonHeight,
          width:Get.width*.50,
          padding: EdgeInsets.all(0),
          decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),
              )

          ),
          child: Center(
            child: Text(
              btnText2,
              style: const TextStyle(
                color: Colors.white,
                fontSize:13,
                fontWeight: AppFonts.normal,
              ),
            ),
          ),
        ),
      ),
    )
  ],
);

