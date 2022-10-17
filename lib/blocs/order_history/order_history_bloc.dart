import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cygneto/blocs/base/base_bloc.dart';
import 'package:cygneto/database/db_module.dart';
import 'package:equatable/equatable.dart';

part 'order_history_event.dart';

part 'order_history_state.dart';

class OrderHistoryBloc extends BaseBloc<OrderHistoryEvent> {
  OrderHistoryBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetOrderRecordListFromDB>((event, emit) async {
      emit(const LoadingState());
      print(queryToGetOrderHistory(
          event.customerId, event.startDate, event.endDate));
      await dbModule.dbInstance.database
          .rawQuery(queryToGetOrderHistory(
              event.customerId, event.startDate, event.endDate))
          .then((value) {
        emit(GetOrderRecordListSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetOrderRecordListFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String queryToGetOrderHistory(
      int customerId, String startDate, String endDate) {
    return "select TT.*, oi.TotalOrder From( "
        "select ord.*, vp.name as VisitPartner_Name, ldr.full_name from OrderRecord as ord "
        "inner join VisitOrderMapping  as vom on vom.order_id = ord.Id "
        "inner join VisitDetail  as vd on vd.id = vom.visit_id "
        "And vd.customer_id = ord.customer_id "
        "left  join VisitPartner  as vp on vp.id= vd.partner_id "
        "left  join LoginDataResponse  as ldr on ldr.user_id  = vd.created_by "
        "where ord.customer_id = $customerId "
        "And Date(ord.order_date)  BETWEEN  '$startDate' AND  '$endDate' ) As TT "
        "Left Join (Select ord.order_id , "
        "Count(ord.id) AS TotalOrder "
        "From OrderItem as ord "
        "Group by ord.order_id "
        ") AS oi on oi.order_id = TT.id";
  }
}
