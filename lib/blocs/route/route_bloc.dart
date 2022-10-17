import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../base/base_bloc.dart';

part 'route_event.dart';

part 'route_state.dart';

class RouteBloc extends BaseBloc<RouteEvent> {
  late DBModule dbModule;

  RouteBloc(this.dbModule) : super() {
    _onEvent();
  }

  void _onEvent() {
    on<GetRouteListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(getSQLQueryToGetTheListOfRoutes())
          .then((value) {
        emit(RouteSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const RouteFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetTotalCustomerCountFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.customerDao.getCustomerData().then((value) {
        emit(TotalCustomerCountSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const TotalCustomerCountFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetOrdersFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(getSQLQueryToGetTheListOfOrders())
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

  String getSQLQueryToGetTheListOfRoutes() =>
      "SELECT R.id, R.name,COUNT(TT.customerId) "
      "AS  totalOutlets,COUNT(VD.customer_id ) "
      "AS visitsCount FROM route R "
      "LEFT JOIN(SELECT ID AS customerId, route_id "
      "FROM  customer C)AS TT "
      "ON R.id = TT.route_id "
      "LEFT JOIN (SELECT Distinct	V.customer_id FROM "
      "VisitDetail AS V Where DATE(V.created_on) = DATE('now')) AS VD "
      "ON VD.customer_id = TT.customerId GROUP BY R.name, R.id";

  String getSQLQueryToGetTheListOfOrders() =>
      "SELECT c.id as customerId,c.business_name as businessName,o.id as orderId,"
      " strftime('%m', o.order_date) as Month , c.route_id as routeId"
      "  FROM customer c"
      "  LEFT JOIN orderrecord o"
      "  ON c.id = o.customer_id and o.order_date>date('now','-90 day')";
}
