import 'package:equatable/equatable.dart';

import '../../data/models/order_item/order_item_data_response.dart';
import '../../data/models/visit_order_mapping/visit_order_item.dart';
import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../../resources/app_strings.dart';
import '../base/base_bloc.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends BaseBloc<CartEvent> {
  late DBModule dbModule;

  CartBloc(this.dbModule) : super() {
    _onEvent();
  }

  void _onEvent() {
    on<GetItemsFromCart>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.cartDao.getAllData().then((value) {
        emit(GetProductFromCartSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetProductFromCartFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetUomListFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.uomDao.getUoMData().then((value) {
        emit(UomCartSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const UomCartFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetProductListCart>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.cartDao.getAllData().then((value) {
        emit(GetProductFromCartSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetProductFromCartFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<DeleteProductFromCart>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.cartDao.deleteData(event.id).then((value) {
        emit(
            DeleteProductFromCartSuccessState(data: value, index: event.index));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const DeleteProductFromCartFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<DeleteAllDataFromCart>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.cartDao.deleteAllData().then((value) {
        emit(DeleteAllDataFromCartSuccessState(
            data: event.needScreenRedirection));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const DeleteAllDataFromCartFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetFreeProduct>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(_createRowQueryToGetFreeProductDetails(
              event.freeProduct.free_product_id!,
              event.freeProduct.free_product_uom!))
          .then((value) {
        if (value.isNotEmpty) {
          event.freeProduct.free_product_uom_name =
              value[0]["uom_name"] as String;
          event.freeProduct.free_product_name = value[0]["name"] as String;
        }
        emit(GetFreeProductDetailsSuccessState(
            data: value, freeProduct: event.freeProduct));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetFreeProductDetailsFailState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<InsertOrderIntoOrderRecord>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.financialYearDao
          .getCurrentFinancialYear()
          .then((value) {
        if (value.isNotEmpty) {
          event.orderRecord.fyId = value[0].id;
        }
      });
      await dbModule.dbInstance.journeyCycleDao
          .getCurrentJourneyCycle(event.orderRecord.fyId!)
          .then((value) {
        if (value!.isNotEmpty) {
          event.orderRecord.jcId = value[0].id;
        }
      });

      await dbModule.dbInstance.orderRecordDao
          .insertOrderRecordData(event.orderRecord)
          .then((value) {
        emit(InsertOrderRecordIntoDBSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const InsertOrderRecordIntoDBFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<InsertOrderItemIntoDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.orderItemDao
          .insertAllData(event.orderItemList)
          .then((value) {
        emit(SaveOrderItemIntoDBSuccessState(data: ''));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const SaveOrderItemIntoDBFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetUnSyncOrderFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.orderRecordDao
          .getUnSyncOrder()
          .then((orderRecordValue) async {
        await dbModule.dbInstance.orderItemDao
            .getUnSyncOrder()
            .then((orderItemValue) {
          List<OrderRecordDataResponse> ordersNeedToPlace = [];
          for (var orderRecord in orderRecordValue) {
            List<OrderItemDataResponse> orderList = [];

            orderList.addAll(orderItemValue
                .where((element) => element?.orderId == orderRecord?.id));

            for (int i = 0; i < orderList.length; i++) {
              orderList[i].id = 0;
              orderList[i].orderId = 0;
            }

            ordersNeedToPlace.add(OrderRecordDataResponse(
                id: 0,
                orderDate: orderRecord.orderDate,
                warehouseId: orderRecord.warehouseId,
                distributorId: orderRecord.distributorId,
                customerId: orderRecord.customerId,
                orderType: orderRecord.orderType,
                totalAmount: orderRecord.totalAmount,
                subscriberId: orderRecord.subscriberId,
                shippingAddress: orderRecord.shippingAddress,
                billingAddress: orderRecord.billingAddress,
                schemeId: orderRecord.schemeId,
                addedDiscount: orderRecord.addedDiscount,
                visitId: orderRecord.visitId,
                created_by: orderRecord.created_by,
                created_on: orderRecord.created_on,
                orderItem: orderList,
                isSync: orderRecord.isSync,
                jcId: orderRecord.jcId,
                fyId: orderRecord.fyId));
          }

          emit(GetUnSyncOrderItemSuccessState(data: ordersNeedToPlace));
          emit(const LoadingState(isLoading: false));
        }).catchError((e) {
          emit(const GetUnSyncOrderItemFailedState(
              msg: AppStrings.msgDataNotAvailable));
          emit(const LoadingState(isLoading: false));
        });
        /*emit(GetUnSyncOrderSuccessState(data: value));
                emit(const LoadingState(isLoading: false));*/
      }).catchError((e) {
        emit(const GetUnSyncOrderFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });


    on<PlaceOrderAPICall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .createPlaceOrderCall(event.placeOrderItem)
          .then((value) {
        emit(PlaceOrderAPICallSuccessState(data: value, index: event.index));
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const PlaceOrderAPICallFailState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<DeleteUnSyncOrder>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.orderRecordDao
          .deleteUnSyncData()
          .then((value) async {
        await dbModule.dbInstance.orderItemDao.deleteUnSyncData().then((value) {
          emit(DeleteUnSyncOrderSuccessState(data: value));
          emit(const LoadingState(isLoading: false));
        });
      }).catchError((e) {
        emit(const DeleteUnSyncOrderFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetLastTimeStampFromDb>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(
              "select max(d) from (select created_on d from OrderRecord union select modified_on d from OrderRecord)")
          .then((value) {
        String? syncDateTime;
        if (value[0]["max(d)"] != null) {
          syncDateTime = value[0]["max(d)"].toString();
        }
        // final _latestDate = LatestDate(
        //     apiSequence: event.apiSequence, latestDate: syncDateTime);
        emit(GetLastSyncDateFromDBSuccessState(data: syncDateTime));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetLastSyncDateFromDBFailState(
            msg: "There is some issue with the database table VisitDetail"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallOrderRecordApi event
    on<CallOrderRecordApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getOrderRecordListCall(
              OrderRecordRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        emit(OrderRecordSuccessState(data: value));
        _saveOrderRecordIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(OrderRecordFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallOrderItemApi event
    on<CallOrderItemApi>((event, emit) async {
      emit(const LoadingState());
      String? syncDateTime;
      await dbModule.dbInstance.database
          .rawQuery("select max(d) from (select created_on d "
              "from OrderItem union select modified_on d from OrderItem)")
          .then((value) {
        if (value[0]["max(d)"] != null) {
          syncDateTime = value[0]["max(d)"].toString();
        }
      });

      await apiService.client!
          .getOrderItemListCall(OrderItemRequest(fromTimeStamp: syncDateTime))
          .then((value) {
        emit(OrderItemSuccessState(data: value));
        _saveOrderItemIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(OrderItemFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on getSchemeData event
    on<GetSchemeDataFromDB>((event, emit) async {
      emit(const LoadingState());
      print(
          getRawQueryToGetTheScheme(2, event.totalAmount, event.totalQuantity));
      await dbModule.dbInstance.database
          .rawQuery(getRawQueryToGetTheScheme(
              2, event.totalAmount, event.totalQuantity))
          .then((value) {
        emit(GetSchemeSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(GetSchemeFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallVisitOrderMappingApi event
    on<GetVisitOrderMappingApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getVisitOrderMapping(
          OrderItemRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) async {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        _saveVisitOrderMappingIntoDatabase(value.data);
        String? syncDateTime;
        await dbModule.dbInstance.database
            .rawQuery("select max(d) from (select created_on d "
        "from visitdetail union select modified_on d from visitdetail)")
            .then((value) {
        if (value[0]["max(d)"] != null) {
        syncDateTime = value[0]["max(d)"].toString();
        }
        });
        emit(GetVisitOrderMappingSuccessState(data: syncDateTime));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(GetVisitOrderMappingFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallVisitApi event
    on<CallVisitApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getVisit(VisitRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      )).then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(VisitSuccessState(data: value));
        _saveVisitDetailIntoDatabase(value.data.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        //Logger.e(tag, e);
        emit(VisitFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }



  Future<void> _saveOrderRecordIntoDatabase(
          List<OrderRecordDataResponse>? userData) async =>
      await dbModule.dbInstance.orderRecordDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveOrderItemIntoDatabase(
          List<OrderItemDataResponse>? userData) async =>
      await dbModule.dbInstance.orderItemDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveVisitOrderMappingIntoDatabase(
      List<VisitOrderItem>? visitOrderItem) async =>
      await dbModule.dbInstance.visitOrderMappingDao
          .insertAllData(visitOrderItem ?? [])
          .then((value) {
        /// updating previous screen.
      });
  Future<void> _saveVisitDetailIntoDatabase(
      List<VisitDataItemsResponse>? userData) async =>
      await dbModule.dbInstance.visitDetailDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });
  String getRawQueryToGetTheScheme(
      int schemeType, double totalAmount, double totalQuantity) {
    return "SELECT * from Scheme "
        "where orderUOM is null "
        "AND schemeType =$schemeType "
        "AND (((minTotalValue is null AND maxTotalValue is null) "
        "OR (minTotalValue<= $totalAmount AND maxTotalValue>=$totalAmount)) "
        "OR ((minOrderQnty is null AND maxOrderQnty is null) "
        "OR (minOrderQnty<= $totalQuantity AND maxOrderQnty>=$totalQuantity))) "
        "AND((startDate is NULL AND endDate is NULL) "
        "OR (strftime('%Y-%m-%dT%H:%M:%S', startDate)<strftime('%Y-%m-%dT%H:%M:%S', 'now') "
        "AND strftime('%Y-%m-%dT%H:%M:%S', endDate)>strftime('%Y-%m-%dT%H:%M:%S', 'now')))";
  }

  String _createRowQueryToGetFreeProductDetails(int id, int selectedUomId) {
    return "select pl.*,uom.uom_name "
        "from productList as pl "
        "LEFT JOIN unitofmeasure as uom "
        "where pl.id = $id  and uom.id=$selectedUomId limit 1";
  }
}
