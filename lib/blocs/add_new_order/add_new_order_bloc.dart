import 'package:cygneto/data/models/AvailableStock/available_stock_request.dart';
import 'package:cygneto/data/models/cart/cart_model.dart';
import 'package:cygneto/data/models/product_list/product_with_price_model.dart';
import 'package:cygneto/exports/resources.dart';
import 'package:cygneto/utilities/logger.dart';
import 'package:equatable/equatable.dart';

import '../../database/db_module.dart';
import '../base/base_bloc.dart';

part 'add_new_order_event.dart';

part 'add_new_order_state.dart';

class AddNewOrderBloc extends BaseBloc<AddNewOrderEvent> {
  AddNewOrderBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetGroupListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.productGroupDao.getAllData().then((value) {
        emit(GroupSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GroupFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetCategoryListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.productCategoryDao.getAllData().then((value) {
        emit(CategorySuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const CategoryFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetUomListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.uomDao.getUoMData().then((value) {
        emit(UomSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const UomFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///product schema data
    on<GetProductSchemaFromDB>((event, emit) async {
      emit(const LoadingState());

      ///we are passing the schemetype =2 as static bcz we required only schemes
      ///for the secondary orders, when we implement the orders for the distributors
      ///too at that time will add that argument as dynamic
      ///
      print(_createQueryToGetTheSchemes(event.id, 2, event.totalAmount,
          event.totalQuantity, event.orderedUomId));
      await dbModule.dbInstance.database
          .rawQuery(_createQueryToGetTheSchemes(event.id, 2, event.totalAmount,
              event.totalQuantity, event.orderedUomId))
          .then((value) {
        emit(ProductSchemaSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const ProductSchemaFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///Add product to cart table
    on<AddProductToCart>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.cartDao
          .insertProductIntoCart(event.productWithPriceModel)
          .then((value) {
        emit(const SuccessState());
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const FailedState(msg: "Data not able to insert in db"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on GetAvailableStock event
    on<GetAvailableStockOrder>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getAvailableStock(AvailableStockRequest(
        warehouseId: event.warehouseId,
        productId: event.productId,
        uoM: event.uoM,
      ))
          .then((value) {
        emit(StockSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(StockFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetProductListCart>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.cartDao.getAllData().then((value) {
        emit(GetProductSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetProductFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
    on<GetProductPrice>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.productPricingDao
          .getAllDataBasedOnProductId(event.productId)
          .then((value) {
        emit(GetProductPriceSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetProductPriceFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetFreeProduct>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database.rawQuery(
          _createRowQueryToGetFreeProductDetails(event.productId, event.uomId))
          .then((value) {
           emit(GetFreeProductSuccessState(data: value));
           emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetFreeProductFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String _createQueryToGetTheSchemes(int productId, int schemeType,
      double totalAmount, int totalQuantity, int orderedUomId) {
    return "SELECT s.*  FROM Scheme as s "
        "INNER JOIN ProductScheme as ps "
        "on s.id=ps.scheme_id and ps.product_id=$productId "
        "WHERE s.schemeType=$schemeType "
        "AND ps.is_active=1 "
        "AND ((s.minTotalValue<= ${totalAmount} AND s.maxTotalValue>=${totalAmount}) "
        "OR (s.minOrderQnty<= ${totalQuantity} AND s.maxOrderQnty>=${totalQuantity})) "
        "AND s.orderUOM=${orderedUomId} AND((s.startDate is NULL AND s.endDate is NULL) "
        "OR (strftime('%Y-%m-%dT%H:%M:%S', s.startDate)<strftime('%Y-%m-%dT%H:%M:%S', 'now') "
        "AND strftime('%Y-%m-%dT%H:%M:%S', s.endDate)>strftime('%Y-%m-%dT%H:%M:%S', 'now')))";
  }

  String _createRowQueryToGetFreeProductDetails(int id, int selectedUomId) {
    return "select pl.*,uom.uom_name "
        "from productList as pl "
        "LEFT JOIN unitofmeasure as uom "
        "where pl.id = $id  and uom.id=$selectedUomId limit 1";
  }
}
