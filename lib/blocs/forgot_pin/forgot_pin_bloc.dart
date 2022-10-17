import 'package:equatable/equatable.dart';

import '../../exports/constants.dart';
import '../../exports/models.dart';
import '../../exports/utilities.dart';
import '../base/base_bloc.dart';

part 'forgot_pin_event.dart';

part 'forgot_pin_state.dart';

class ForgotPinBloc extends BaseBloc<ForgotPinEvent> {
  ForgotPinBloc() : super() {
    _onEvent();
  }

  static String tag = "ForgotPinBloc";

  /// Created by Dev 2136 on 12/24/2021
  /// Modified by Dev 2136 on 12/24/2021
  /// Purpose : on event handler
  void _onEvent() {
    ///on SendOtpButtonPressed event
    on<SendOtpButtonPressed>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doForgotPin(ForgotPinRequest(
        mobileNumber: event.mobileNumber,
      ))
          .then((value) {
        if (event.forgotPinApiType == ForgotPinApiType.sendOtp) {
          emit(SuccessState(data: value));
        } else {
          emit(ResendOtpSuccessState(data: value));
        }
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        if (event.forgotPinApiType == ForgotPinApiType.sendOtp) {
          emit(FailedState(msg: apiService.getError(e)));
        } else {
          emit(ResendOtpFailedState(msg: apiService.getError(e)));
        }
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on VerifyOtpButtonPressed event
    on<VerifyOtpButtonPressed>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doVerifyOTP(VerifyOtpRequest(
        mobileNumber: event.mobileNumber,
        otp: event.otp,
      ))
          .then((value) {
        emit(VerifyOtpSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(VerifyOtpFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }
}
