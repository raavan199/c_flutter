import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../constants/app_constants.dart';
import '../../database/db_module.dart';
import '../../resources/app_strings.dart';
import '../base/base_bloc.dart';

part 'sales_return_history_event.dart';

part 'sales_return_history_state.dart';

class SalesReturnHistoryBloc extends BaseBloc<SalesReturnHistoryEvent> {
  SalesReturnHistoryBloc(this.dbModule) : super() {
    _onEvent();
  }

  //variable declaration
  late DBModule dbModule;

  void _onEvent() {
    on<GetSalesReturnHistory>((event, emit) async {
      emit(const LoadingState());
      print(getQueryToGetTheSalesReturn(
          event.customerId, event.startDate, event.endDate));
      await dbModule.dbInstance.database
          .rawQuery(getQueryToGetTheSalesReturn(
              event.customerId, event.startDate, event.endDate))
          .then((value) {
        emit(SalesReturnHistorySuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const SalesReturnHistoryFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetSalesAdjustment>((event, emit) async {
      emit(const LoadingState());
      print(getQueryToGetTheSalesAdjustment(event.customerId,event.startDate,event.endDate));
      await dbModule.dbInstance.database
          .rawQuery(getQueryToGetTheSalesReturn(event.customerId,event.startDate,event.endDate))
          .then((value) {
        emit(SalesReturnHistorySuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const SalesReturnHistoryFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String getQueryToGetTheSalesReturn(
      int customerId, String startDate, String endDate) {
    return "SELECT pl.name as productName,uom.uom_name as uomName,sr.* FROM SalesReturn as sr "
        "LEFT JOIN productList as pl on pl.id=sr.productId "
        "LEFT JOIN unitofmeasure as uom on uom.id=sr.uoM "
        "where sr.customerId=$customerId "
        "and DATE(sr.returnDate) between DATE('$startDate') and DATE('$endDate')";
  }

  String getQueryToGetTheSalesAdjustment(
      int customerId, String startDate, String endDate) {
    return "SELECT pl.name as productName,uom.uom_name as uomName,sr.* FROM SalesReturn as sr "
        "LEFT JOIN productList as pl on pl.id=sr.productId "
        "LEFT JOIN unitofmeasure as uom on uom.id=sr.uoM "
        "where sr.customerId=$customerId and sr.isApprove=1 and sr.isCancel=0 "
        "and DATE(sr.returnDate) between DATE('$startDate') and DATE('$endDate')";
  }
}
