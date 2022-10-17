import 'package:equatable/equatable.dart';

import '../../data/models/leave/leave_item.dart';
import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../base/base_bloc.dart';

part 'apply_leave_event.dart';
part 'apply_leave_state.dart';

class ApplyLeaveBloc extends BaseBloc<ApplyLeaveEvent> {
  ApplyLeaveBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {

    on<CallApplyLeaveAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .applyLeaveCall(event.leaveData)
          .then((value) {
        emit(ApplyLeaveCallSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(ApplyLeaveCallFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallOrderItemApi event
    on<CallLeaveTypeAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getLeaveType(
          OrderItemRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        emit(LeaveTypeSuccessState(data: value.data));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(LeaveTypeFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });


  }
}
