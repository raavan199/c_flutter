import 'package:cygneto/blocs/route/route_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../base/base_bloc.dart';

part 'customer_event.dart';

part 'customer_state.dart';

class CustomerBloc extends BaseBloc<CustomerEvent> {
  late DBModule dbModule;

  CustomerBloc(this.dbModule) : super() {
    _onEvent();
  }

  void _onEvent() {
    on<GetCustomersBasedOnRoutes>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerDao
          .getCustomerDataBasedOnRouteId(event.routeId)
          .then((value) {
        emit(GetCustomersSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetCustomersFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetRoutesCountFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.routeDao.getAllData().then((value) {
        emit(GetRoutesCountSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const FailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetOrdersMappingFromDB>((event, emit) async {
      emit(const LoadingState());
      print(getSQLQueryToGetTheListOfOrders(event.routeId));
      await dbModule.dbInstance.database
          .rawQuery(getSQLQueryToGetTheListOfOrders(event.routeId))
          .then((value) {
        emit(GetOrderListSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetOrderListFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String getSQLQueryToGetTheListOfOrders(int routeId) =>
      "SELECT c.id as customerId,c.business_name as businessName,o.id as orderId, nor.id as noOrderId, "
      "strftime('%m', o.order_date) as Month , c.route_id as routeId, "
      "(strftime('%Y-%m-%d', 'now')=strftime('%Y-%m-%d', o.order_date))as orderDate, "
      "(strftime('%Y-%m-%d', 'now')=strftime('%Y-%m-%d', nor.created_on))as noOrderDate "
      "FROM customer c "
      "LEFT JOIN orderrecord o ON c.id = o.customer_id and o.order_date>date('now','-90 day') "
      "LEFT JOIN noorder nor  ON c.id = nor.customer_id and nor.created_on>date('now','-90 day') "
      "where c.route_id=$routeId";
}
