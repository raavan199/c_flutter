import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity/connectivity.dart';

import '../../app_config.dart';
import '../../exports/constants.dart';
import '../../exports/mixins.dart';
import '../../exports/utilities.dart';
import '../../repository/api_client.dart';
import '../shared_preference_service.dart';

/// Created by Dev 2301 on 10/28/2021
/// Modified by Dev 2301 on 10/28/2021
/// Purpose : Api service class that will set the client

class ApiService with UtilityMixin {
  ApiService() {

    setApiClient();
  }

  final Dio _dio = Dio();
  ApiClient? client;
  String? _jwtToken;

  ///  This method is used to get API client. Here, i have set
  /// the interceptor to perform session expiry task and also added code for
  /// cookie delete.
  Future<Dio> getApiClient() async {
    const baseUrl = AppConfig.apiEnvironment;
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (option, handler) async {
          await getHeadersAndAddLogInterceptor(option);
          handler.next(option);
        },
        onResponse: (response, handler) async {
          handler.next(response);
        },
        onError: (err, handler) async {
          /// logging exception and sending it to respected view.
          handler.reject(err);
        },
      ),
    );
    if (!kReleaseMode) {
      _dio.interceptors.add(LoggingInterceptor());
    }

    return _dio;
  }

  /// method to get error message from response
  String getError(dynamic e) {
    var err = "Something went wrong";
    try {
      if (e.type == DioErrorType.response) {
        final message = e.response.data["message"]?.toString() ?? err;
        err = message;
      } else if (e.message.toString().contains('SocketException')) {
        err = "Please check your internet connection";
      }
    } catch (e) {
      return err;
    }
    return err;
  }

  /// get access token from storage and append in header also adding
  /// all other required headers.
  getHeadersAndAddLogInterceptor(RequestOptions options) async {
    _jwtToken = await SharedPreferenceService()
        .getStringValuesSF(SharedPrefsConstants.jwtToken);

    if (_jwtToken != null) {
      options.headers[APIHeaderConstants.authorization] =
      '${APIHeaderConstants.bearer}$_jwtToken';
    }
    options.connectTimeout = Timeout.connectTimeout;
    options.receiveTimeout = Timeout.receiveTimeout;
  }

  /// This method is used to set api client.
  Future<void> setApiClient() async {
    client = ApiClient(await getApiClient());
  }

  // This method is used check internet connectivity
  Future<bool> checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
