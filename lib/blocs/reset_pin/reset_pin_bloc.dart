import 'package:equatable/equatable.dart';

import '../../exports/models.dart';
import '../../exports/utilities.dart';
import '../base/base_bloc.dart';

part 'reset_pin_event.dart';
part 'reset_pin_state.dart';

class ResetPinBloc extends BaseBloc<ResetPinEvent> {
  ResetPinBloc() : super() {
    _onEvent();
  }

  static String tag = "ResetPinBloc";

  /// Created by Dev 2136 on 12/24/2021
  /// Modified by Dev 2136 on 12/24/2021
  /// Purpose : on event handler
  void _onEvent() {
    ///on ResetPinButtonPressed event
    on<ResetPinButtonPressed>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doResetPin(ResetPinRequest(
        mobileNumber: event.mobileNumber,
        pin: event.pin,
      ))
          .then((value) {
        emit(SuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(FailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }
}
