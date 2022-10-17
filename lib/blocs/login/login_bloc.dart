import 'package:cygneto/exports/resources.dart';
import 'package:cygneto/services/api/api_service.dart';
import 'package:equatable/equatable.dart';

import '../../constants/app_constants.dart';
import '../../data/models/login/login_data_response.dart';
import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../../exports/utilities.dart';
import '../../services/shared_preference_service.dart';
import '../base/base_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

/// Created by Dev 2301 on 10/28/2021
/// Modified by Dev 2301 on 10/28/2021
/// Purpose : business logic component for login screen
class LoginBloc extends BaseBloc<LoginEvent> {
  LoginBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;
  static String tag = "LoginBloc";

  /// Created by Dev 2301 on 10/28/2021
  /// Modified by Dev 2136 on 12/23/2021
  /// Purpose : on event handler
  void _onEvent() {
    ///on LoginButtonPressed event
    on<LoginButtonPressed>((event, emit) async {
      emit(const LoadingState());
      await ApiService().checkInternet().then((internet) async => {
            if (internet)
              {
                await apiService.client!
                    .doLogin(LoginRequest(
                  mobileNumber: event.mobileNumber,
                  pin: event.pin,
                ))
                    .then((value) async {
                  await SharedPreferenceService()
                      .getStringValuesSF(SharedPrefsConstants.number)
                      .then((loginNumber) {
                    if (loginNumber != null &&
                        loginNumber != event.mobileNumber) {
                      print("different Login");
                      SharedPreferenceService().removeAllData();
                      dbModule.deleteDatabase();
                    }
                  });
                  emit(LoginSuccessState(data: value, pin: event.pin));
                  await _saveIntoDatabase(value.userData, event.pin);
                  emit(const LoadingState(isLoading: false));
                }).catchError((e) {
                  Logger.e(tag, e);
                  emit(LoginFailedState(msg: apiService.getError(e)));
                  emit(const LoadingState(isLoading: false));
                })
              }
            else
              {
                await dbModule.dbInstance.loginDao
                    .getPinHashData()
                    .then((value) {
                  emit(PinHashSuccessState(data: value));
                  emit(const LoadingState(isLoading: false));
                }).catchError((e) {
                  Logger.e(tag, e);
                  emit(const PinHashFailedState(
                      msg: AppStrings.msgInternetShouldOnFirstTime));
                  emit(const LoadingState(isLoading: false));
                })
              }
          });
      // return;
    });
  }

  Future<void> _saveIntoDatabase(LoginDataResponse userData, pin) async =>
      await dbModule.dbInstance.loginDao
          .insertLoginData(LoginDataResponse(
        fullName: userData.fullName,
        email: userData.email,
        jwtToken: userData.jwtToken,
        refreshToken: userData.refreshToken,
        image: userData.image,
        userId: userData.userId,
        isAdmin: userData.isAdmin,
        userRoleName: userData.userRoleName,
        //pinHash: userData.pinHash,
        pinHash: pin,
      ))
          .then((value) async {
        await dbModule.dbInstance.userRoleRightsDao
            .insertAllData(userData.userRoleRights ?? []);

        /// updating previous screen.
      });
}
