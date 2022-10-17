import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../database/db_module.dart';
import '../../exports/resources.dart';
import '../base/base_bloc.dart';

part 'order_item_event.dart';

part 'order_item_state.dart';

class OrderItemBloc extends BaseBloc<OrderItemEvent> {
  OrderItemBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetOrderDataFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(queryToGetOrderData(event.orderId))
          .then((value) async {
        await dbModule.dbInstance.database
            .rawQuery(queryToGetOrderScheme(event.orderId))
            .then((schemeValue) {

          emit(OrderDataSuccessState(data: value,schemeData: schemeValue));
        });
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const OrderDataFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetDistributorName>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.distributionDao
          .getDistributionObject(event.distributorId)
          .then((value) {
        emit(DistributionObjectSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const DistributionObjectFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String queryToGetOrderData(int orderId) {
    return "Select oi.*, pl.name as name,um.uom_name as selected_uom, sc.name as scheme_name From OrderItem as oi "
        "Inner Join productList  as pl on pl.id =oi.product_id "
        "Inner Join UnitOfMeasure as um on um.id =oi.uom "
        "Left  Join Scheme  as sc on sc.id =oi.scheme_id "
        "Where oi.order_id=$orderId";
  }

  String queryToGetOrderScheme(int orderId) {
    return "select s.* from orderrecord as ord "
        "inner join scheme as s on s.id=ord.scheme_id "
        "where ord.id =$orderId";
  }
}
