import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../base/base_bloc.dart';

part 'no_order_type_event.dart';
part 'no_order_type_state.dart';

class NoOrderTypeBloc extends BaseBloc<NoOrderTypeEvent> {
  NoOrderTypeBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetNoOrderTypeFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.noOrderTypeDio.getNoOrderType().then((value) {
        emit(GetNoOrderTypeSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetNoOrderTypeFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<InsertNoOrderIntoDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.noOrderDao
          .insertOrderItemData(event.request)
          .then((value) {
        emit(const InsertNoOrderIntoDBSuccessState(data: ''));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const InsertNoOrderIntoDBFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetUnSyncNoOrder>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.noOrderDao.getUnSyncNoOrder().then((value) {
        emit(GetUnSyncNoOrderSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetUnSyncNoOrderFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<NoOrderAPICall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doNoOrderCall(event.request)
          .then((value) {
        emit(NoOrderApiCallSuccessSate(data: value));
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const NoOrderApiCallFailedState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<DeleteUnSyncNoOrderFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.noOrderDao.deleteUnSyncData().then((value) {
        emit(DeleteUnSyncNoOrderSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const DeleteUnSyncNoOrderFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetNewNoOrder>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(
          "select max(d) from (select created_on d from NoOrder union select modified_on d from NoOrder)")
          .then((value) async {
        String? syncDateTime;
        if (value[0]["max(d)"] != null) {
          syncDateTime = value[0]["max(d)"].toString();
        }
        await apiService.client!
            .getNoOrder(SchemeListRequest(
            pageIndex: 1, fromTimeStamp: syncDateTime))
            .then((value) {
          _saveNoOrderIntoDatabase(value.data?.items);
          value.lastSyncTimeStamp = syncDateTime;
          emit(NoOrderSuccessState(data: value));
          emit(const LoadingState(isLoading: false));
        }).catchError((e) {
          emit(NoOrderFailedState(msg: apiService.getError(e)));
          emit(const LoadingState(isLoading: false));
        });
        return;
      }).catchError((e) {
        emit(const NoOrderFailedState(msg: "There is some issue with the database table NoOrder"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  Future<void> _saveNoOrderIntoDatabase(List<NoOrderRequest>? noOrder) async =>
      await dbModule.dbInstance.noOrderDao
          .insertAllData(noOrder ?? [])
          .then((value) {
        /// updating previous screen.
      });

}
