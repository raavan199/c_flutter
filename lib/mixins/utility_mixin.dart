import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../exports/models.dart';
import '../exports/constants.dart';
import '../exports/resources.dart';
import '../exports/themes.dart';
import '../exports/utilities.dart';
import '../services/shared_preference_service.dart';
import '../ui/widgets/custom_dialog.dart';

/// Created by Dev 2301 on 7/23/2021
/// Modified by Dev 2301 on 7/23/2021
/// Purpose : mixin for all common utility methods
mixin UtilityMixin {
  static String tag = "UtilityMixin";

  /// Created by Dev 2301 on 7/23/2021
  /// Modified by Dev 2301 on 7/23/2021
  /// Purpose : clear back stack of the screen and place on the top
  void clearStackAndAddScreen(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  /// Created by Dev 2301 on 12/1/2021
  /// Modified by Dev 2301 on 12/1/2021
  /// Purpose : function to hide keyboard
  void hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  ///Purpose : navigate to next screen and not manage stack
  void navigationPushReplacement(BuildContext context, var routeName) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => routeName,
      ),
    );
  }

  ///Purpose : navigate to next screen and manage back press
  void navigationPush(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  Future<void> navigationWithAwaitPush(BuildContext context, Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  /// Created by Dev 2301 on 8/16/2021
  /// Modified by Dev 2301 on 8/16/2021
  /// Purpose : method to display snack bar of common types
  void showSnackBar(BuildContext context, String message,
      {SnackBarStyle style = SnackBarStyle.normal, int duration = 2}) {
    final textStyle = style == SnackBarStyle.success
        ? CustomTextStyle.snackBarSuccessTextStyle
        : style == SnackBarStyle.error
            ? CustomTextStyle.snackBarErrorTextStyle
            : CustomTextStyle.snackBarNormalTextStyle;
    final color = style == SnackBarStyle.success
        ? AppColors.colorSuccessBg
        : style == SnackBarStyle.error
            ? AppColors.colorErrorBg
            : AppColors.colorNormalBg;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: textStyle),
      margin: const EdgeInsets.all(AppDimens.commonPadding),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(AppDimens.commonPadding)),
      ),
      duration: Duration(seconds: style == SnackBarStyle.error ? 3 : duration),
      backgroundColor: color,
    ));
  }

  /// Created by Dev 1051 on 7/28/2021
  /// Modified by Dev 1051 on 7/28/2021
  /// Purpose : This method is used to get header widget for pull to refresh.
  Widget getPullToRefreshHeaderWidget() => const MaterialClassicHeader(
      height: 70, color: AppColors.black, backgroundColor: AppColors.primary);

  /// Created by Dev 1051 on 8/3/2021
  /// Modified by Dev 1051 on 8/3/2021
  /// Purpose : This method is used to get date time from string
  DateTime getDateTimeFromString(String date) => DateTime.parse(date);

  /// Created by Dev 1051 on 8/3/2021
  /// Modified by Dev 1051 on 8/3/2021
  /// Purpose : This method is used to get date in fix format.
  String getDateInParticularFormat(DateTime date, String format) =>
      DateFormat(format).format(date);

  /// Created by Dev 2301 on 8/3/2021
  /// Modified by Dev 2301 on 8/3/2021
  /// Purpose : This method is used to launch url.
  Future launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      showSnackBar(context, 'Could not launch.', style: SnackBarStyle.error);
    }
  }

  /// Created by Dev 1051 on 8/13/2021
  /// Modified by Dev 2301 on 8/27/2021
  /// Purpose : This method is used to get date in week day hour format.
  /// added support for unix timestamp conversion
  String getDateInWeekDayHourFormat({String? date, int? unixStamp}) {
    try {
      late DateTime postdate;
      if (date != null) {
        postdate = getDateTimeFromString(date);
      }
      if (unixStamp != null) {
        postdate = DateTime.fromMillisecondsSinceEpoch(unixStamp * 1000);
      }
      final difference = DateTime.now().difference(postdate).inMilliseconds;
      final seconds = (difference / 1000).round();
      final minutes = (seconds / 60).round();
      final hours = (minutes / 60).round();
      final days = (hours / 24).round();
      final weeks = (days / 7).round();
      if (seconds < 60) {
        return "$seconds${AppStrings.secondInitialChar}";
      } else if (minutes < 60) {
        return "$minutes${AppStrings.minuteInitialChar}";
      } else if (hours < 24) {
        return "$hours${AppStrings.hourInitialChar}";
      } else if (days < 7) {
        return "$days${AppStrings.dayInitialChar}";
      } else {
        return "$weeks${AppStrings.weekInitialChar}";
      }
    } catch (e) {
      Logger.d(tag, "exception in getDateInWeekDayHourFormat : $e");
      return "";
    }
  }

  /// Created by Dev 2196 on 8/19/2021
  /// Modified by Dev 2196 on 8/19/2021
  /// Purpose : This method is used to get date in week day hour year format.
  String getDateInYearWeekDayHourFormat({String? date, int? unixStamp}) {
    try {
      late DateTime postdate;
      if (date != null) {
        postdate = getDateTimeFromString(date);
      }
      if (unixStamp != null) {
        postdate = DateTime.fromMillisecondsSinceEpoch(unixStamp * 1000);
      }
      final difference =
          DateTime.now().toUtc().difference(postdate).abs().inMilliseconds;

      final seconds = (difference / 1000).round();
      final minutes = (seconds / 60).round();
      final hours = (minutes / 60).round();
      final days = (hours / 24).round();
      final weeks = (days / 7).round();
      final year = (weeks / 52).round();
      if (seconds < 60) {
        return "$seconds${AppStrings.secondInitialChar}";
      } else if (minutes < 60) {
        return "$minutes${AppStrings.minuteInitialChar}";
      } else if (hours < 24) {
        return "$hours${AppStrings.hourInitialChar}";
      } else if (days < 7) {
        return "$days${AppStrings.dayInitialChar}";
      } else if (weeks < 52) {
        return "$weeks${AppStrings.weekInitialChar}";
      } else {
        return "$year${AppStrings.yearInitialChar}";
      }
    } catch (e) {
      Logger.d(tag, "exception in getDateInWeekDayHourFormat : $e");
      return "";
    }
  }

  /// Created by Dev 2196 on 8/3/2021
  /// Modified by Dev 2301 on 8/11/2021
  /// Purpose : This method is used to captureImage from camera or gallery.
  Future<File?> getMedia({required MediaSource source}) async {
    File? file;
    if (source == MediaSource.camera) {
      final _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        file = File(image.path);
      }
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.media,
      );
      if (result != null) {
        file = File(result.files.single.path!);
      }
    }
    return file;
  }

  /// Created by Dev 2196 on 8/3/2021
  /// Modified by Dev 2301 on 8/12/2021
  /// Purpose : This method is used to generate unique id from given filepath.
  String generateUploadId(String filepath) {
    const uuid = Uuid();
    return uuid
        .v5(
          Uuid.NAMESPACE_URL,
          "${DateTime.now().millisecond}_${getFileName(filepath)}",
        )
        .toString();
  }

  /// Created by Dev 2301 on 8/12/2021
  /// Modified by Dev 2301 on 8/12/2021
  /// Purpose : function to get file name from filepath
  String getFileName(String filepath) =>
      filepath.substring(filepath.lastIndexOf("/") + 1, filepath.length);

  /// Created by Dev 2301 on 8/12/2021
  /// Modified by Dev 2301 on 8/12/2021
  /// Purpose : function to get extension from filename
  String getFileExt(String filename) =>
      filename.substring(filename.lastIndexOf(".") + 1, filename.length);

  /// Created by Dev 2301 on 8/17/2021
  /// Modified by Dev 2301 on 8/17/2021
  /// Purpose : format date time as per given format
  String getFormattedDateTime(DateTime dateTime, {String? format}) {
    try {
      final formattedDate =
          DateFormat(format ?? DateFormats.dateFormatDdMmYyyy).format(dateTime);
      Logger.d(tag, "formattedDate: $formattedDate");

      return formattedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in  getFormattedDate: $e");
      return dateTime.toString();
    }
  }

  /// Created by Dev 2301 on 8/18/2021
  /// Modified by Dev 2301 on 8/18/2021
  /// Purpose : combine given date and time
  /// convert datetime to unix format
  int? convertToUnix(DateTime date, DateTime time) {
    try {
      final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        time.second,
      );
      final convertedDate = (dateTime.toUtc().millisecondsSinceEpoch) ~/ 1000;
      Logger.d(tag, "dateTime: $dateTime");
      Logger.d(tag, "convertToUnix: $convertedDate");
      return convertedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in convertToUnix: $e");
    }
  }

  /// Created by Dev 2301 on 8/18/2021
  /// Modified by Dev 2301 on 8/18/2021
  /// Purpose : combine given date and time
  /// convert datetime to unix format
  int? convertDateTimeToUnix(DateTime date) {
    try {
      final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
      );
      final convertedDate = (dateTime.toUtc().millisecondsSinceEpoch) ~/ 1000;
      Logger.d(tag, "dateTime: $dateTime");
      Logger.d(tag, "convertToUnix: $convertedDate");
      return convertedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in convertToUnix: $e");
    }
  }

  /// Created by Dev 2301 on 8/18/2021
  /// Modified by Dev 2301 on 8/18/2021
  /// Purpose : combine given date and time
  /// convert datetime to unix format
  int convertDateTimeToUnixUTC(DateTime date, {int? firstDay}) {
    try {
      final dateTime =
          DateTime.utc(date.year, date.month, firstDay ?? date.day);
      final convertedDate = (dateTime.millisecondsSinceEpoch) ~/ 1000;
      Logger.d(tag, "dateTime: $dateTime");
      Logger.d(tag, "convertToUnix: $convertedDate");
      return convertedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in convertToUnix: $e");
    }
    return 0;
  }

  /// Created by Dev 2183 on 1/13/2022
  /// Modified by
  /// Purpose : generate random number between range
  int generateRandomNumber() {
    int result;
    const minimum = -500;
    const maximum = -100;
    var random = Random();
    result = minimum + random.nextInt((maximum - minimum) + 1);
    print('random number = $result');
    return result;
  }

  /// Created by Dev 2183 on 1/21/2022
  /// Modified by Dev  on
  /// Purpose : combine given date and time
  /// convert return name of VisitType from Id
  String getVisitTypeName(int visitType) {
    if (visitType == VisitTypeId.singleVisit) {
      return AppStrings.single;
    } else if (visitType == VisitTypeId.jointVisit) {
      return AppStrings.joint;
    } else {
      return 'N/A';
    }
  }

  /// Created by Dev 2183 on 03/31/2022
  /// Modified by Dev  on
  /// Purpose : combine orderMapping delivery status Id and
  /// convert return name of delivery status from Id
  String getDeliveryStatusName(int deliveryStatusId) {
    switch (deliveryStatusId) {
      case InvoiceDeliveryStatusId.Delivered:
        return "Delivered";
      case InvoiceDeliveryStatusId.InTransit:
        return "In Transit";
      case InvoiceDeliveryStatusId.Loaded:
        return "Loaded";
      case InvoiceDeliveryStatusId.OnHold:
        return "On Hold";
      case InvoiceDeliveryStatusId.NotLoaded:
      default:
        return "Not Loaded";
    }
  }

  /// Created by Dev 2183 on 1/21/2022
  /// Modified by Dev
  /// Purpose : get only Time from DateTime String
  String getTimeFromDateAndTime(String date) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(date).toLocal();
      return DateFormat.jm().format(dateTime).toString();
    }
    catch (e) {
    return date;
    }
  }

  /// Created by Dev 2183 on 1/21/2022
  /// Modified by Dev
  /// Purpose : get only Date from DateTime String
  String getDateFromDateTime(String date, {String? format}) {
    final formatter = format ?? DateFormats.ddMMyyyy;
    var dateTime;
    try {
      dateTime = DateTime.parse(date).toLocal();
      return DateFormat(formatter).format(dateTime);
    } catch (e) {
      return date;
    }
  }

  String getDateAndMonthFromDateTime(String date, {String? format}) {
    var formater = format ?? 'dd/MMM';
    var dateTime;
    try {
      dateTime = DateTime.parse(date);
      return formatDate(dateTime, [dd, '/', M]);
    } catch (e) {
      return date;
    }
  }

  /// Created by Dev 2183 on 1/21/2022
  /// Modified by Dev
  /// Purpose : get only Date from DateTime String
  String getDateFromDate(DateTime date, {String? format}) {
    final formatter = format ?? DateFormats.ddMMyyyy;
    try {
      return DateFormat(formatter).format(date);
    } catch (e) {
      return '';
    }
  }

  /// Created by Dev 2183 on 1/21/2022
  /// Modified by Dev
  /// Purpose : get only Date from DateTime String used in Outlet photos
  String getDateAndTimeFromCreatedOn(String date) {
    var dateTime;
    try {
      dateTime = DateTime.parse(date).toLocal();
      return formatDate(
          dateTime, [dd, '/', M, '/', yyyy, ' | ', hh, ':', mm, ':', ss]);
    } catch (e) {
      return date;
    }
  }

  String getCurrentDateAndTime() {
    var now = DateTime.now().toIso8601String();
    return '$now+05:30';
  }

  String convertDateForPassInQueryFormat(DateTime date) =>
      formatDate(date, [yyyy, '-', mm, '-', dd]);

  String getCurrentDate({String? format}) {
    final formatter = format ?? DateFormats.ddMMyyyy;
    return DateFormat(formatter).format(DateTime.now());
  }

  String get12HTime(DateTime time) => DateFormat.jm().format(time);

  String get12HTimeString(String time) =>
      DateFormat.jm().format(DateTime.parse(time).toLocal());

  String getDateAndTImeWithTimeZone(DateTime date) {
    var dateTime = date.toIso8601String();
    return '$dateTime+05:30';
  }

  DateTime convertStringToDateTime(String date, {String? format}) {
    final formatter = format ?? DateFormats.yyyyMMddHhMmSs;
    var dateTime = DateFormat("dd/MM/yyyy hh:mm:ss").parse(date);

    return DateTime.parse(DateFormat(formatter).format(dateTime));
  }

  /// Created by Dev 2183 on 1/21/2022
  /// Modified by Dev
  /// Purpose : show Alert dialog for no internet

  void showNoInternetDialog(BuildContext context, {String? content}) {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              content: content ?? AppStrings.msgInternetShouldOnFirstTime,
              title: AppStrings.lblNoInternet,
              yes: AppStrings.ok,
              yesOnPressed: () {},
            ));
  }

  void showCustomDialog(
      BuildContext context, String content, String title, String _yes,
      {Function? yesOnPressed, String? no, Function? noOnPressed}) {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              content: content,
              title: title,
              yes: _yes,
              no: no,
              yesOnPressed: () {
                if (yesOnPressed != null) {
                  yesOnPressed();
                }
              },
              noOnPressed: () {
                Navigator.of(context).pop(false);
                print('alert dialog no clicked');
                if (noOnPressed != null) {
                  noOnPressed();
                }
              },
            ));
  }

  Future<File> prepareImageFile(Uint8List data, int id) async {
    var filename = '$id.jpg';
    String dir = (await getTemporaryDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(data);
    print("file path: " + file.path);
    return file;
  }

  Future<LoginDataResponse> fetchUserDataFromSharedPreference() async {
    final userDataInString = await SharedPreferenceService()
        .getStringValuesSF(SharedPrefsConstants.userDataResponse);
    final Map<String, dynamic> userDataInMap = jsonDecode(userDataInString!);
    final loginDataResponse = LoginDataResponse.fromJson(userDataInMap);
    return loginDataResponse;
  }
}

void showCustomFlushBar(BuildContext context, String? msg) {
  Flushbar(
    title: AppStrings.lblFieldSales.toUpperCase(),
    message: msg!.isNotEmpty ? msg : AppStrings.msgDataNotAvailable,
    duration: const Duration(seconds: 3),
  ).show(context);
}

bool checkDifference(DateTime startTime, DateTime endTime) {
  final diff = endTime.difference(startTime);
  if (diff.isNegative) {
    return false;
  } else {
    return true;
  }
}
