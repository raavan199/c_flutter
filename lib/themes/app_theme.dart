import 'dart:ui';

import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 1051 on 7/13/2021
/// Purpose : This is a style helper file, it is used to,
/// - Used to store the various style settings
/// - appTheme is the main theme for the whole application
///   Note: do not change the theme for the main app

final ThemeData appTheme = ThemeData(
  fontFamily: AppFonts.fontName,
  primaryColor: AppColors.primary,
  hintColor: AppColors.hint,
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 16, color: AppColors.hint),
    labelStyle: TextStyle(fontSize: 18, color: AppColors.primary),
    errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 28, color: AppColors.primary, fontWeight: FontWeight.w400),
  ),
  dividerColor: Colors.grey,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: AppColors.white),
  ),
);
