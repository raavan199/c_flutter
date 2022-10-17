library app_constants;

import 'package:cygneto/constants/app_enums.dart';
import 'package:cygneto/exports/resources.dart';

///this class holds shared preference key constants used throughout the app
class PrefKeys {
  static const String accessToken = "accessToken";
  static const String userEmail = "userEmail";
  static const String userId = "userId";
  static const String userType = "userType";
  static const String businessUserType = "businessUserType";
  static const String lstReadTime = "lastReadTime";
  static const String timerValue = "timerValue";
}

/// @created By: Jarchita Bhesaniya(2301)
/// @Created Date: 3/2/2021
/// @Purpose:this class holds numeric constants used throughout app
class NumericConstants {
  static const int otpLength = 6;
  static const int passwordPinLength = 6;
  static const int phoneNumberLength = 10;
}

/// @created By: Jarchita Bhesaniya(2301)
/// @Created Date: 3/2/2021
/// @Purpose:this class holds numeric constants used throughout app
class DataConstants {
  static const List<String> allowedExtensions = ['jpg', 'pdf', 'jpeg', 'png'];
  static const List<String> allowedChatFileExtensions = [
    'jpg',
    'pdf',
    'jpeg',
    'png',
    'mp4',
    'mp3',
    'mov',
  ];
  static const String uaeCountryCode = '971';
  static const String dateFormatddmmyyyy = 'dd/MM/yyyy';
  static const String dateFormatddmmyyyyTime = 'dd/MM/yyyy hh:mm aaa';
}

///use this values to determine user type throughout the app
class UserTypes {
  static const String b2b = 'B2B_MOBILE';
  static const String b2c = 'B2C_MOBILE';
}

class Timeout {
  static const int connectTimeout = 600000;
  static const int receiveTimeout = 600000;
}

class Delay {
  Delay._();

  static const int screenTransitionDelayMillis = 1000;
  static const int downloadApiCallIntervalInMinutes = 30;
  static const int oneSecond = 1;
  static const int postDelayInMinutes = 15;
}

class APIHeaderConstants {
  APIHeaderConstants._();

  static const authorization = "Authorization";
  static const connectTimeout = "connectTimeout";
  static const receiveTimeout = "receiveTimeout";
  static const bearer = "Bearer ";
  static const cookie = "cookie";
  static const setCookie = "set-cookie";
}

class SharedPrefsConstants {
  SharedPrefsConstants._();

  static const String authorizationToken = "authorization_token";
  static const String emailId = "email_id";
  static const String password = "password";
  static const String jwtToken = "jwtToken";
  static const String userId = "userId";
  static const String number = "number";
  static const String visitId = "visitId";
  static const String scopeId = "scopeId";
  static const String userDataResponse = "userDataResponse";
}

class ResponseCode {
  ResponseCode._();

  static const int successOk = 200;
  static const int successCreated = 201;
  static const int successAccepted = 202;
  static const int successNoContent = 204;
  static const int errorMovedPermanently = 301;
  static const int errorFound = 302;
  static const int errorBadRequest = 400;
  static const int errorUnauthorized = 401;
  static const int errorForbidden = 403;
  static const int errorNotFound = 404;
  static const int errorMethodNotAllowed = 405;
  static const int errorNotAcceptable = 406;
  static const int errorInternalServerError = 500;
  static const int errorNotImplemented = 501;
}

class PageIndex {
  PageIndex._();
  static const int pageSize = 50;
}

class LoadingStatus {
  LoadingStatus._();

  static const String start = "loading";
  static const String campaignStart = "campaignLoading";
  static const String complete = "done";
}

class DateFormats {
  DateFormats._();

  static const String mmDdYyyy = "MM/dd/yyyy";
  static const String ddMMyyyy = "dd/MM/yyyy";
  static const String ddMMyyyyDash = "dd-MM-yyyy";
  static const String yyyyMMddDash = "yyyy-MM-dd";
  static const String yyyyMMdd = "yyyy-MM-dd";
  static const String yyyyMMddHhMmSs = "yyyy-MM-dd hh:mm:ss.SSS";
  static const String ddMYyyyHhMmSs = "dd-M-yyyy hh:mm:ss";
  static const String ddMmMmYyyy = "dd MMMM yyyy";
  static const String eDdMmmYyyyHhMmSs = "E, dd MMM yyyy HH:mm:ss";
  static const String eEeeHhMma = "EEEE hh:mm a";
  static const String mmmDdYyyyHhMmSsa = "MMM dd, yyyy, hh:mm:ss a";
  static const String dateFormatDdMmYyyy = "dd/MM/yyyy";
  static const String dateFormatLong = "dd MMMM yyyy";
  static const String timeFormat = "h:mm aaa";
  static const String timeFormatWithSpacing = "h : mm aaa";
  static const String eEeeDdMmm = "EEEE dd MMMM";
  static const String mmYYYY = "MM-yyyy";
  static const String hHMm = "HH:mm";
  static const String createdOn_modifiedOn_dateFormat =
      'YYYY-MM-DD hh:mm:ss.SSSTZD';
}

class APICallStatus {
  APICallStatus._();

  static const int inProgress = 2;
  static const int success = 1;
  static const int failure = 0;
}

class SyncStatus {
  SyncStatus._();

  static const int unSync = 0;
  static const int sync = 1;
}

class VisitTypeId {
  VisitTypeId._();

  static const int singleVisit = 1;
  static const int jointVisit = 2;
}

class LeaveStatusId {
  LeaveStatusId._();

  static const int pending = 1;
  static const int approved = 2;
  static const int rejected = 3;
  static const int cancelled = 4;
}
class MissPunchFilterId {
  MissPunchFilterId._();

  static const int needToApply = 0;
  static const int pending = 1;
  static const int approved = 2;
  static const int rejected = 3;
  static const int expired = 4;
}
class BaseStatus {
  BaseStatus._();

  static const int inActive = 0;
  static const int active = 1;
  static const int deleted = 2;
}

class PunchType{
  PunchType._();

  static const int punchIn = 1;
  static const int punchOut = 2;
}

class ImageModule{
  ImageModule._();

  static const int customer = 1;
  static const int attendance = 2;
}

class ActivityRegisterStatus{
  ActivityRegisterStatus._();

  static const int Pending = 1;
  static const int Approved = 2;
  static const int Rejected = 3;
  static const int Cancelled = 4;
}

class OrderTypeStatus {
  OrderTypeStatus._();

  static const int FieldSales = 1;
  static const int DirectSales = 2;
}

class PaymentModeId {
  PaymentModeId._();

  static const int UPI = 1;
  static const int cheque = 2;
  static const int online = 3;
  static const int cash = 4;
  static const int card = 5;
  static const int NA = 6;
}

class InvoiceDeliveryStatusId {
  InvoiceDeliveryStatusId._();

  static const int NotLoaded  = 0;
  static const int Loaded  = 1;
  static const int OnHold  = 2;
  static const int InTransit  = 3;
  static const int Delivered  = 4;
}
