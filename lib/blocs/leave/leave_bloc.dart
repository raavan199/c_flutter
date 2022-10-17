import 'package:cygneto/exports/models.dart';
import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../base/base_bloc.dart';

part 'leave_event.dart';

part 'leave_state.dart';

class LeaveBloc extends BaseBloc<LeaveEvent> {
  LeaveBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<CallLeaveApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getLeave(SchemeListRequest(
              fromTimeStamp: event.fromTimeStamp, pageIndex: event.pageIndex))
          .then((value) {
        _saveLeaveIntoDatabase(value.data!.items);
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CallLeaveSuccessState(data: value.data!.items, leave: value.data!.leaves));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(CallLeaveFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<ManageLeaveAPiCall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .applyLeaveCall(event.leaveData)
          .then((value) {
        emit(ManageLeaveCallSuccessState(data: value));
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const ManageLeaveCallFailState(msg: "API call Fail!"));
        // emit(const PlaceOrderAPICallFailState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  Future<void> _saveLeaveIntoDatabase(
      List<LeaveItem>? leave) async =>
      await dbModule.dbInstance.leaveDao
          .insertAllData(leave ?? [])
          .then((value) {
        /// updating previous screen.
      });
}
