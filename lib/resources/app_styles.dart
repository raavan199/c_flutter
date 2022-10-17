import 'package:flutter/material.dart';
import '../exports/resources.dart';

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2301 on 11/26/2021
/// Purpose : place style specific constants over here
abstract class AppStyles {
  ///appbar
  static const appBarElevation = 1.0;
  static const appBarIconTheme = IconThemeData(
    color: AppColors.primary,
  );
  static const appBarIconThemeLight = IconThemeData(
    color: Colors.white,
  );

  ///text field
  static const txtFieldLabelStyle =
      TextStyle(color: AppColors.primary, fontSize: 13);
  static const txtFieldLoginScreenLabelStyle =
      TextStyle(color: Colors.white, fontSize: 13);

  ///common container
  static const commonContainer = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(commonCornerRadius),
        topRight: Radius.circular(commonCornerRadius)),
  );

  ///borders
  static const tableHeaderCellDecoration = BoxDecoration(
      border: Border(
        right: BorderSide(
          color: AppColors.bg,
        ),
      ),
      color: AppColors.primary);

  ///dropdown styles
  static const dropdownHeight = 40;
  static const dropdownPadding = EdgeInsets.symmetric(horizontal: 10);
  static const dropdownBtnText = TextStyle(
    color: Colors.black,
    fontSize: 13,
  );
  static const dropdownMenuItemText = TextStyle(
    color: Colors.black,
    fontSize: 12,
  );

  ///other
  static const commonPadding = EdgeInsets.all(20);
  static const primaryButtonHeight = 50.0;
  static const commonCornerRadius = 30.0;
  static const commonCardCornerRadius = 5.0;
  static const pageSideMargin = 15.0;
  static const calendarHeaderMargin = 50.0;
  static const calendarMargin = 30.0;
  static const SalesAdjustCardHeight=68.0;
}
