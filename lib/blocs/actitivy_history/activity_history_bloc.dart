import 'package:equatable/equatable.dart';

import '../../data/models/activty_register/activity_registered_item.dart';
import '../../database/db_module.dart';
import '../../exports/resources.dart';
import '../base/base_bloc.dart';

part 'activity_history_event.dart';

part 'activity_history_state.dart';

class ActivityHistoryBloc extends BaseBloc<ActivityHistoryEvent> {
  ActivityHistoryBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetActivityHistory>((event, emit) async {
      emit(const LoadingState());
      print(rawQueryToGetActivityHistory(event.startDate, event.endDate));
      await dbModule.dbInstance.database
          .rawQuery(
              rawQueryToGetActivityHistory(event.startDate, event.endDate))
          .then((value) {
        emit(GetActivityHistorySuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetActivityHistoryFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
    on<DeleteActivityAPICall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .deleteActivity(event.id)
          .then((value) async{
            await dbModule.dbInstance.activityRegisteredDao.deleteActivityById(event.id).then((value){
              emit(DeleteActivityAPISuccessState(id: event.id));
              emit(const LoadingState(isLoading: false));
            }).catchError((e){
              emit(const DeleteActivityAPIFailedState(msg: AppStrings.msgDataNotAvailable));
              emit(const LoadingState(isLoading: false));
            });
      }).catchError((e){
        emit( DeleteActivityAPIFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<DeleteActivityById>((event, emit) async {
      emit(const LoadingState());
        await dbModule.dbInstance.activityRegisteredDao.deleteActivityById(event.id).then((value){
          emit(DeleteActivityByIdSuccessState(id: event.id));
          emit(const LoadingState(isLoading: false));
        }).catchError((e){
          emit(const DeleteActivityByIdFailedState(msg: AppStrings.msgDataNotAvailable));
          emit(const LoadingState(isLoading: false));
        });
      return;
    });
    

  }

  String rawQueryToGetActivityHistory(String startDate, String endDate) =>
      "SELECT a.*, at.name as ActivityTypeName FROM ActivityRegistered as a "
        "left join  ActivityRegisterType as at on a.activityTypeId = at.id "
        "where DATE(a.created_on) between DATE('$startDate') and DATE('$endDate')";
}
