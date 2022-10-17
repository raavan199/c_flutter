import 'package:flutter/material.dart';
import '../exports/resources.dart';

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 1051 on 7/19/2021
/// Purpose : This is a custom text style class used to handle all custom
/// styles.
class CustomTextStyle {
  CustomTextStyle._();

  static TextStyle inputFieldLabel = const TextStyle(
      color: AppColors.black, fontSize: 14, fontWeight: AppFonts.medium);

  static TextStyle inputFieldText = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 14,
      overflow: TextOverflow.ellipsis,
      fontWeight: AppFonts.normal);

  static TextStyle filterHeaderTextStyle = const TextStyle(
      color: AppColors.filterHeaderColor,
      fontSize: 12,
      fontWeight: AppFonts.normal);

  static TextStyle calendarHeaderTextStyle = const TextStyle(
      fontSize: 14, fontWeight: AppFonts.bold, color: AppColors.black);

  static TextStyle timeLineTextStyle = const TextStyle(
      fontSize: 14, fontWeight: AppFonts.bold, color: AppColors.txtTimeColor);

  static TextStyle normalTextStyle = const TextStyle(
      color: AppColors.black, fontSize: 14, fontWeight: AppFonts.normal);

  static TextStyle smallTextStyle = const TextStyle(
      color: AppColors.black, fontSize: 12, overflow: TextOverflow.ellipsis, fontWeight: AppFonts.normal);

  static TextStyle receiptTextStyle = const TextStyle(
      color: AppColors.white, fontSize: 12, fontWeight: AppFonts.normal);

  static TextStyle transactionTitleTextStyle = const TextStyle(
      color: AppColors.white, fontSize: 12, fontWeight: AppFonts.bold);

    static TextStyle blackBold12TextStyle = const TextStyle(
      color: AppColors.black, fontSize: 12, fontWeight: AppFonts.bold);

  static TextStyle filterValueTextStyle = const TextStyle(
      color: AppColors.black, fontSize: 28, fontWeight: AppFonts.normal);

  static TextStyle smallGreyTextStyle = const TextStyle(
      color: AppColors.accentGery, fontSize: 12, fontWeight: AppFonts.normal);

  static TextStyle normalUnderlineTextStyle = const TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: AppFonts.normal,
      decoration: TextDecoration.underline);

  static TextStyle subHeaderTextStyle = const TextStyle(
      color: AppColors.black, fontSize: 16, fontWeight: AppFonts.semiBold);

  static TextStyle screenHeaderTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.white,
      fontSize: 14,
      fontWeight: AppFonts.bold,
      letterSpacing: 1);

  static TextStyle headerSubTitleTextStyle = const TextStyle(
    fontFamily: AppFonts.fontName,
    color: AppColors.white,
    fontSize: 12,
    fontWeight: AppFonts.normal,
  );

  static TextStyle screenNameUnderlineTextStyle = const TextStyle(
      color: AppColors.accentYellow,
      fontSize: 14,
      fontWeight: AppFonts.normal,
      decoration: TextDecoration.underline);

  static TextStyle retailerNameTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 13,
      fontWeight: AppFonts.normal);

  static TextStyle mobileNumberTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 13,
      fontWeight: AppFonts.bold);

  static TextStyle imageDetailsTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 12,
      fontWeight: AppFonts.bold);

  static TextStyle orderNumberTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      fontSize: 12,
      fontWeight: AppFonts.bold,
      color: AppColors.txtTimeColor);

  static TextStyle avlStockTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.primary,
      fontSize: 11,
      fontWeight: AppFonts.normal);

  static TextStyle switchPrimaryTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.primary,
      fontSize: 13,
      fontWeight: AppFonts.medium);

  static TextStyle punchInTextStyle = const TextStyle(
    fontFamily: AppFonts.fontName,
    fontSize: 12,
    fontWeight: AppFonts.extraBold,
    color: AppColors.primary,
  );

  static TextStyle blackBold11 = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 11,
      fontWeight: AppFonts.bold);
  static TextStyle primaryBold11 = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.primary,
      fontSize: 11,
      fontWeight: AppFonts.bold);

  static TextStyle blackNormal11 = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 11,
      fontWeight: AppFonts.normal);


  ///--------------------------------------------------
  static TextStyle largeBoldTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: AppDimens.defaultLargeTextSize,
      fontWeight: AppFonts.bold);

  static TextStyle mediumTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: AppDimens.defaultMediumTextSize,
      fontWeight: AppFonts.medium);

  static TextStyle rememberMeTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 15,
      fontWeight: AppFonts.medium);

  static TextStyle buttonTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.white,
      fontSize: 14,
      fontWeight: AppFonts.semiBold);

  static TextStyle dialogTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 13,
      fontWeight: AppFonts.normal);

  static TextStyle snackBarSuccessTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.colorSuccess,
      fontSize: AppDimens.defaultNormalTextSize,
      fontWeight: AppFonts.normal);

  static TextStyle snackBarNormalTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.colorNormal,
      fontSize: AppDimens.defaultNormalTextSize,
      fontWeight: AppFonts.normal);

  static TextStyle snackBarErrorTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.colorError,
      fontSize: AppDimens.defaultNormalTextSize,
      fontWeight: AppFonts.normal);

  static TextStyle titleTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 17,
      fontWeight: AppFonts.bold);

  static TextStyle buttonTitleTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 11,
      fontWeight: AppFonts.semiBold);

  static TextStyle dialogButtonStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 17,
      fontWeight: AppFonts.medium);
  static TextStyle dialogHeaderStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 17,
      fontWeight: AppFonts.medium);

  static TextStyle textCounterStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 11,
      fontWeight: AppFonts.medium);

  static TextStyle remainingCharacterStyle = const TextStyle(
      fontFamily: AppFonts.fontName, color: AppColors.black, fontSize: 10);
  static TextStyle noDataContent = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 12,
      fontWeight: AppFonts.medium);

  static TextStyle tabBarLabelTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.black,
      fontSize: 14,
      fontWeight: AppFonts.medium);

  static TextStyle appbarTextStyle = const TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.white,
      fontSize: 18,
      fontWeight: AppFonts.semiBold);
}
