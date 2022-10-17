import 'package:equatable/equatable.dart';

import '../../data/models/activty_register/activity_registered_item.dart';
import '../../data/models/activty_register/save_activity_register_request.dart';
import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../base/base_bloc.dart';

part 'activity_register_event.dart';

part 'activity_register_state.dart';

class ActivityRegisterBloc extends BaseBloc<ActivityRegisterEvent> {
  ActivityRegisterBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetActivityRegisterTypesFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.activityRegisterTypeDao
          .getAllData()
          .then((value) {
        emit(GetActivityTypesSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetActivityTypesFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<InsertActivityRegisterIntoDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.activityRegisteredDao
          .insertActivityRegisterData(event.activityData)
          .then((value) {
        emit(const InsertActivitySuccessState(data: ""));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const InsertActivityFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetUnSyncActivityRegister>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.activityRegisteredDao
          .getUnSyncActivity()
          .then((value) async {
        List<ActivityRegisteredItem> unsyncData = value;
        if (unsyncData.isNotEmpty) {
          for (var i = 0; i < unsyncData.length; i++) {
            if (unsyncData[i].id! < 0) {
              unsyncData[i].id = 0;
            }
          }
        }
        await apiService.client!
            .saveActivityRegister(SaveActivityRegisterRequest(data: unsyncData))
            .then((value)async {
          await dbModule.dbInstance.activityRegisteredDao
              .deleteUnSyncData()
              .then((value) async {
            GetLatestActivityRegister(1);
          });
        });
      }).catchError((e) {
        emit(const GetUnSyncActivityFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  Future<void> _saveActivityRegisteredIntoDatabase(
          List<ActivityRegisteredItem>? activity) async =>
      await dbModule.dbInstance.activityRegisteredDao
          .insertAllData(activity ?? [])
          .then((value) {
        /// updating previous screen.
      });

  void GetLatestActivityRegister(int pageIndex) async {
    await dbModule.dbInstance.database
        .rawQuery(
        "select max(d) from (select created_on d from ActivityRegistered union select modified_on d from ActivityRegistered)")
        .then((value) async {
      String? syncDateTime;
      if (value[0]["max(d)"] != null) {
        syncDateTime = value[0]["max(d)"].toString();
      }
      await apiService.client!
          .getActivityRegistered(SchemeListRequest(
        pageIndex: 1,
        fromTimeStamp: syncDateTime,
      ))
          .then((value) {
        print("getActivityRegistered success");
        _saveActivityRegisteredIntoDatabase(value.data!.items);
        if (value.data!.hasNextPage == true) {
          GetLatestActivityRegister(pageIndex + 1);
        } else {
          emit(GetActivityRegisteredAPISuccessState(data: value));
          emit(const LoadingState(isLoading: false));
        }
      }).catchError((e) {
        emit(const GetActivityRegisteredAPIFailedState(
            msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
    });
  }
}
