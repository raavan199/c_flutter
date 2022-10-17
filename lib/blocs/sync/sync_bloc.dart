import 'package:cygneto/data/models/financial_year/financial_year_data.dart';
import 'package:cygneto/data/models/invoice/invoice_statement_item.dart';
import 'package:cygneto/data/models/invoice/manage_payment_collection_request.dart';
import 'package:cygneto/data/models/journey_cycle/journey_cycle_data.dart';
import 'package:cygneto/data/models/order_item/order_item_data_response.dart';
import 'package:cygneto/data/models/order_item/order_item_request.dart';
import 'package:cygneto/data/models/product_trends/product_trends_item.dart';
import 'package:cygneto/data/models/sales_return/sales_return_item.dart';
import 'package:cygneto/data/models/visit_order_mapping/visit_order_item.dart';
import 'package:cygneto/exports/resources.dart';
import 'package:equatable/equatable.dart';

import '../../dao/invoice_mapping_dao.dart';
import '../../data/models/LatestDate.dart';
import '../../data/models/closing_balance/closing_balance.dart';
import '../../data/models/customer/customer_data_items_response.dart';
import '../../data/models/customer_type/customer_type_data_response.dart';
import '../../data/models/district/district_items_response.dart';
import '../../data/models/district/district_request.dart';
import '../../data/models/invoice/invoice_item.dart';
import '../../data/models/invoice/order_invoice_mapping.dart';
import '../../data/models/location/location_request.dart';
import '../../data/models/product_category_list/product_category_list_data_items_response.dart';
import '../../data/models/product_group_list/product_group_request.dart';
import '../../data/models/product_list/product_list_data_items_response.dart';
import '../../data/models/product_pricing_list/product_pricing_request.dart';
import '../../data/models/route/get_route_by_user_items.dart';
import '../../data/models/route/get_route_by_user_request.dart';
import '../../data/models/sacheme_list/scheme_list_data_response.dart';
import '../../data/models/sales_return/sales_return_reason.dart';
import '../../data/models/sales_return/sales_return_request.dart';
import '../../data/models/state/state_data_item_response.dart';
import '../../data/models/unitofmeasurement/unit_of_measurement_data_response.dart';
import '../../data/models/visit/visit_data_items_response.dart';
import '../../data/models/visit_partners/visit_partners_data_response.dart';
import '../../data/models/warehouse/warehouse_data_items_response.dart';
import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../../exports/utilities.dart';
import '../../ui/screens/sync_data/sync_data_screen.dart';
import '../base/base_bloc.dart';

part 'sync_event.dart';

part 'sync_state.dart';

class SyncBloc extends BaseBloc<SyncEvent> {
  SyncBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;
  static String tag = "SyncBloc";
  int? apiNo;

  /// Created by Dev 2136 on 10/28/2021
  /// Modified by Dev 2136 on 12/23/2021
  /// Purpose : on event handler
  void _onEvent() {
    ///to get the last sync date from the DB
    on<GetLastTimeStampFromDb>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(
              "select max(d) from (select created_on d from ${event.tableName} union select modified_on d from ${event.tableName})")
          .then((value) {
        String? syncDateTime;
        if (value[0]["max(d)"] != null) {
          syncDateTime = value[0]["max(d)"].toString();
        }
        final _latestDate = LatestDate(
            apiSequence: event.apiSequence, latestDate: syncDateTime);
        emit(SuccessState(data: _latestDate));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(FailedState(
            msg:
                "There is some issue with the database table ${event.tableName}"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallGetRouteApi event
    on<CallGetRouteApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doGetRouteByUser(GetRouteByUserRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(RouteSuccessState(data: value));
        _saveRouteIntoDatabase(value.routeData!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(RouteFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    ///on CallCustomerApi event
    on<CallCustomerApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getCustomer(CustomerRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CustomerSuccessState(data: value));
        _saveCustomerIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CustomerFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallCustomerTypeApi event
    on<CallCustomerTypeApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getCustomerType(CustomerTypeRequest(
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CustomerTypeSuccessState(data: value));
        _saveCustomerTypeIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CustomerTypeFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallDistributionApi event
    on<CallDistributionApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doDistributionCall(DistributionRequest(
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(DistributionSuccessState(data: value));
        _saveDistributionIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(DistributionFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallWarehouseApi event
    on<CallWarehouseApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getWarehouse(WarehouseRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(WarehouseSuccessState(data: value));
        _saveWarehouseIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(WarehouseFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallProductListApi event
    on<CallProductListApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getProductList(ProductListRequest(
        pageIndex: event.pageIndex,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(ProductListSuccessState(data: value));
        _saveProductIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(ProductListFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallUOMApiEvent event
    on<CallUOMApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doUnitOfMeasurementCall(UOMRequest(
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        emit(UOMSuccessState(data: value));
        _saveUoMIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(UOMFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallProductGroupListApi event
    on<CallProductGroupListApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doProductGroupListCall(ProductGroupRequest(
        pageIndex: event.pageIndex,
        status: event.status,
        sortBy: event.sortBy,
        sortDesc: event.sortDesc,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(ProductGroupListSuccessState(data: value));
        _saveProductGroupIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(ProductGroupListFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallProductCategoryListApi event
    on<CallProductCategoryListApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getProductCategoryList(ProductCategoryListRequest(
        pageIndex: event.pageIndex,
        status: event.status,
        sortBy: event.sortBy,
        sortDesc: event.sortDesc,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(ProductCategoryListSuccessState(data: value));
        _saveProductCategoryIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(ProductCategoryListFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallProductPricingListApiEvent event
    on<CallProductPricingListApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doProductPricingListCall(
              ProductPricingRequest(pageIndex: event.pageIndex))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(ProductPricingListSuccessState(data: value));
        _saveProductPricingIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(ProductPricingListFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallSchemeListApi event
    on<CallSchemeListApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getSchemeList(SchemeListRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(SchemeListSuccessState(data: value));
        _saveSchemeIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(SchemeListFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallProductSchemaRegisterListApiEvent event
    on<CallProductSchemaRegisterListApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doProductSchemaRegisterListCall(ProductSchemaRequset(
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        emit(ProductSchemaRegisterListSuccessState(data: value));
        _saveProductSchemeIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(ProductSchemaRegisterListFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallVisitPartnersApi event
    on<CallVisitPartnersApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getVisitPartners(
              VisitPartnersRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        emit(VisitPartnersSuccessState(data: value));
        _saveVisitPartnersIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(VisitPartnersFailedState(msg: apiService.getError(e)));
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
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(VisitSuccessState(data: value));
        _saveVisitDetailIntoDatabase(value.data.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(VisitFailedState(msg: apiService.getError(e)));
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
        // value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(OrderRecordSuccessState(data: value));
        _saveOrderRecordIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(OrderRecordFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallOrderItemApi event
    on<CallOrderItemApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getOrderItemListCall(
              OrderItemRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        emit(OrderItemSuccessState(data: value));
        _saveOrderItemIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(OrderItemFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallVisitOrderMappingApi event
    on<CallVisitOrderMappingApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getVisitOrderMapping(
              OrderItemRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(VisitOrderMappingSuccessState(data: value));
        _saveVisitOrderMappingIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(VisitOrderMappingFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on Call ProductTrendsAPIs event
    on<ProductTrendsApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getProductTrends(GetRouteByUserRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(ProductTrendsSuccessState(data: value));
        _saveProductTrendsIntoDatabase(value.data.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(ProductTrendsFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    ///on CallCustomerCategoryApiEvent event
    on<CallCustomerCategoryApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doCustomerCategoryListApiCall(
              CustomerCategoryRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        emit(CustomerCategorySuccessState(data: value));
        _savecustomercategoryIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CustomerCategoryFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallCountryListApiEvent event
    on<CallCountryListApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!.doCountryListCall().then((value) {
        _saveCountryIntoDatabase(value.data);
        emit(CountryListSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CountryListFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    /// on CallStateAPi event
    on<CallStateApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getState(StateRequest(
        pageIndex: event.pageIndex,
      ))
          .then((value) {
        emit(StateSuccessState(data: value));
        _saveStateIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(StateFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    /// on CallDistrictApiEvent event
    on<CallDistrictApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doDistrictCall(DistrictRequest(
        pageIndex: event.pageIndex,
      ))
          .then((value) {
        emit(DistrictSuccessState(data: value));
        _saveDistrictIntoDatabase(value.routeData!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(DistrictFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallLocationListApiEvent event
    on<CallLocationListApiEvent>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doLocationListCall(LocationRequest(
              pageIndex: event.pageIndex, fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(LocationSuccessState(data: value));
        _saveLocationIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(LocationFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallImageFolderApi event
    on<CallImageFolderAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .doImageFolderListCall(ImageFolderRequest(
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(ImageFolderSuccessState(data: value));
        _saveImageFolderIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(ImageFolderFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallCustomerImageApi event
    on<CallCustomerImageApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getCustomerImages(SchemeListRequest(
              fromTimeStamp: event.fromTimeStamp, pageIndex: event.pageIndex))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CustomerImageSuccessState(data: value));
        _saveCustomerImageIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CustomerImageFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallNoOrderTypeAPI event
    on<CallNoOrderTypeAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getNoOrderType(OrderItemRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        emit(NoOrderTypeSuccessState(data: value));
        _saveNoOrderTypeIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(NoOrderTypeFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///To get the sales return history.
    on<GetSalesReturnHistory>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getSalesReturn(
              OrderRecordRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(SalesReturnSuccessState(data: value));
        if (value.data?.isNotEmpty == true) {
          _saveSalesReturnHistoryIntoDatabase(value.data!);
        }
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(SalesReturnFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetInvoices>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getInvoices(LocationRequest(
              pageIndex: event.pageIndex, fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(GetInvoiceSuccessState(data: value));
        if (value.data?.items?.isNotEmpty == true) {
          _saveInvoicesIntoDatabase(value.data!.items!);
          for (final invoiceItems in value.data!.items!) {
            _saveInvoiceItemsIntoDatabase(invoiceItems.secondaryInvoiceItems!);
          }
        }
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(SalesReturnFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetSalesReturnReason>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getSalesReturnReason(
              OrderRecordRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(SalesReturnReasonSuccessState(data: value));
        if (value.data?.isNotEmpty == true) {
          _saveSalesReturnReasonIntoDatabase(value.data!);
        }
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(SalesReturnReasonFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    ///on LeaveApiCall event
    on<LeaveApiCall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getLeave(SchemeListRequest(
              fromTimeStamp: event.fromTimeStamp, pageIndex: event.pageIndex))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CallLeaveAPISuccessState(data: value));
        _saveLeaveIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CallLeaveAPIFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on CallAttendanceAPI event
    on<CallAttendanceAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getAttendance(SchemeListRequest(
              fromTimeStamp: event.fromTimeStamp, pageIndex: event.pageIndex))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CallAttendanceAPISuccessState(data: value));
        _saveAttendanceIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CallAttendanceAPIFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on Call CallActivityRegisterTypeAPI event
    on<CallActivityRegisterTypeAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getActivityRegisterType(OrderItemRequest(
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CallActivityRegisterTypeAPISuccessState(data: value));
        _saveActivityRegisterTypeIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CallActivityRegisterTypeAPIFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    ///on CallActivityRegisteredAPIs event
    on<CallActivityRegisteredAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getActivityRegistered(SchemeListRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(CallActivityRegisteredAPISuccessState(data: value));
        _saveActivityRegisteredIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(CallActivityRegisteredAPIFailState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<CallNoOrderAPI>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getNoOrder(SchemeListRequest(
              pageIndex: event.pageIndex, fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        emit(NoOrderSuccessState(data: value));
        value.lastSyncTimeStamp = event.fromTimeStamp;
        _saveNoOrderIntoDatabase(value.data?.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(NoOrderFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetJourneyCycleList>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getJourneyCycle(
              OrderRecordRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(JourneyCycleSuccessState(data: value));
        if (value.data?.isNotEmpty == true) {
          _saveJourneyCycleIntoDatabase(value.data!);
        }
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(JourneyCycleFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetFinancialYearList>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getFinancialYear(
              OrderRecordRequest(fromTimeStamp: event.fromTimeStamp))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(FinancialYearSuccessState(data: value));
        if (value.data?.isNotEmpty == true) {
          _saveFinancialYearIntoDatabase(value.data!);
        }
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(FinancialYearFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
    });

    ///
    ///  Upload API call
    ///

    on<GetUnSyncVisitPunchFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.visitDetailDao
          .getUnSyncPunchVisit()
          .then((value) {
        emit(GetUnSyncVisitPunchSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetUnSyncVisitPunchFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<ManageVisitPunchAPICall>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .manageVisitPunchCall(ManageVisitPunchRequest(event.request))
          .then((value) {
        emit(ManageVisitPunchAPICallSuccessState(data: value));
        print("API Call Success");
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(
            const ManageVisitPunchAPICallFailState(msg: "Data Not available!"));
        print("API call fail : ${e.toString()}");
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<DeleteUnSyncVisitFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.visitDetailDao.deleteUnSyncData().then((value) {
        emit(DeleteUnSyncVisitSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const DeleteUnSyncVisitFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetUnSyncOrderFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.orderRecordDao
          .getUnSyncOrder()
          .then((orderRecordValue) async {
        await dbModule.dbInstance.orderItemDao
            .getUnSyncOrder()
            .then((orderItemValue) async {
          List<OrderRecordDataResponse> ordersNeedToPlace = [];
          for (var orderRecord in orderRecordValue) {
            await dbModule.dbInstance.visitDetailDao
                .getVisitIDByScopeId(orderRecord.visitId ?? -1)
                .then((value) {
              if (value != null || value != 0) {
                orderRecord.visitId = value?.id!;
              }
            });
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

    on<GetUnSyncNoOrder>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.noOrderDao
          .getUnSyncNoOrder()
          .then((noOrderList) async {
            if(noOrderList.isNotEmpty) {
              for (var noOrder in noOrderList) {
                await dbModule.dbInstance.visitDetailDao
                    .getVisitIDByScopeId(noOrder.visitId ?? -1)
                    .then((value) {
                  if (value != null || value != 0) {
                    noOrder.visitId = value?.id!;
                  }
                });
              }
            }
        emit(GetUnSyncNoOrderSuccessState(data: noOrderList));
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
      await apiService.client!.doNoOrderCall(event.request).then((value) {
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

    on<GetUnSyncSalesReturn>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.salesReturnDao
          .getAllUnSyncData()
          .then((unSyncedValue) async {
        if (unSyncedValue.isNotEmpty) {
          for (var salesReturn in unSyncedValue) {
            await dbModule.dbInstance.visitDetailDao
                .getVisitIDByScopeId(salesReturn.visitId ?? -1)
                .then((value) {
              if (value != null || value != 0) {
                salesReturn.visitId = value?.id!;
              }
            });
          }

          for (var i = 0; i < unSyncedValue.length; i++) {
            if (unSyncedValue[i].id! < 0) {
              unSyncedValue[i].id = 0;
            }
          }
          await apiService.client!
              .addSalesReturn(SalesReturnRequest(unSyncedValue))
              .then((value) async {
            await dbModule.dbInstance.salesReturnDao.deleteUnSyncedData();
            emit(const PostSalesReturnSuccessState());
            emit(const LoadingState(isLoading: false));
          }).catchError((onError) {
            emit(PostSalesReturnFailedState(msg: onError));
            emit(const LoadingState(isLoading: false));
          });
          return;
        } else {
          emit(const PostSalesReturnSuccessState());
          emit(const LoadingState(isLoading: false));
        }
      }).catchError((e) {
        emit(const PostSalesReturnFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetUnSyncAttendance>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.attendanceDao
          .getUnSyncAttendance()
          .then((attendanceItem) async {
        await dbModule.dbInstance.attendanceDetailDao
            .getUnSyncAttendanceDetailData()
            .then((attendanceDetail) async {
          if (attendanceItem.isNotEmpty && attendanceDetail.isNotEmpty) {
            for (int i = 0; i < attendanceItem.length; i++) {
              List<AttendanceDetails> list = [];
              for (AttendanceDetails attendanceDetails in attendanceDetail) {
                if (attendanceItem[i].id == attendanceDetails.attendanceId) {
                  if (attendanceDetails.id! < 0 &&
                      attendanceDetails.attendanceId! < 0) {
                    attendanceDetails.attendanceId = 0;
                    attendanceDetails.id = 0;
                  } else if (attendanceDetails.attendanceId! > 0 &&
                      attendanceDetails.id! < 0) {
                    attendanceDetails.id = 0;
                  }
                  list.add(attendanceDetails);
                }
              }
              attendanceItem[i].attendanceDetails = list;
              if (attendanceItem[i].id! < 0) {
                attendanceItem[i].id = 0;
              }
            }
            await apiService.client!
                .uploadAttendance(UploadAttendanceRequest(data: attendanceItem))
                .then((value) async {
              await dbModule.dbInstance.attendanceDao
                  .deleteUnSyncData()
                  .then((value) async {
                await dbModule.dbInstance.attendanceDetailDao
                    .deleteUnSyncData()
                    .then((value) =>
                        emit(UploadAttendanceSuccessState(data: value)));
                emit(const LoadingState(isLoading: false));
              });
            }).catchError((e) {
              emit(const UploadAttendanceFailedState(
                  msg: 'Something went wrong'));
              emit(const LoadingState(isLoading: false));
            }).catchError((e) {
              emit(const GetUnSyncAttendanceFailedState(
                  msg: AppStrings.msgDataNotAvailable));
              emit(const LoadingState(isLoading: false));
            });
          } else {
            emit(GetUnSyncAttendanceSuccessState(data: attendanceItem));
            emit(const LoadingState(isLoading: false));
          }
        }).catchError((e) {
          emit(const GetUnSyncAttendanceFailedState(
              msg: AppStrings.msgDataNotAvailable));
          emit(const LoadingState(isLoading: false));
        });
        return;
      });
    });

    on<GetUnSyncActivityRegistered>((event, emit) async {
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
          await apiService.client!
              .saveActivityRegister(
                  SaveActivityRegisterRequest(data: unsyncData))
              .then((value) async {
            await dbModule.dbInstance.activityRegisteredDao
                .deleteUnSyncData()
                .then((value) {
              emit(UploadActivityRegisterSuccessState(data: value));
              emit(const LoadingState(isLoading: false));
            });
          }).catchError((e) {
            emit(
                const UploadAttendanceFailedState(msg: 'Something went wrong'));
            emit(const LoadingState(isLoading: false));
          });
        } else {
          emit(GetUnSyncActivityRegisterSuccessState(data: value));
          emit(const LoadingState(isLoading: false));
        }
      }).catchError((e) {
        emit(const GetUnSyncActivityRegisterFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
    on<CallGetInvoiceStatementApi>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getInvoiceStatement(GetRouteByUserRequest(
        pageIndex: event.pageIndex,
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        value.lastSyncTimeStamp = event.fromTimeStamp;
        emit(InvoiceStatementSuccessState(data: value));
        _saveInvoiceStatementsIntoDatabase(value.data!.items);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(InvoiceStatementFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<PostPaymentCollection>((event, emit) async {
      emit(const LoadingState());

      await dbModule.dbInstance.invoiceStatementDao
          .getUnSyncedStatements()
          .then((unSyncedStatements) async {
        final list = <InvoiceStatementItem>[];
        unSyncedStatements?.forEach((statementElement) {
          statementElement.id = 0;
          list.add(statementElement);
        });
        if(unSyncedStatements!=null) {
          for (var paymentCollection in unSyncedStatements!) {
            await dbModule.dbInstance.visitDetailDao
                .getVisitIDByScopeId(paymentCollection.visitId ?? -1)
                .then((value) {
              if (value != null || value != 0) {
                paymentCollection.visitId = value?.id!;
              }
            });
          }
        }
        final request = ManagePaymentCollectionRequest(list);
        await apiService.client!
            .postInvoiceStatement(request)
            .then((postValue) async {
          await dbModule.dbInstance.invoiceStatementDao.deleteUnSyncedData();
          emit(PostInvoiceStatementSuccessState());
          emit(const LoadingState(isLoading: false));
        }).catchError((onError) {
          emit(const PostInvoiceStatementFailedState());
          emit(const LoadingState(isLoading: false));
        });
      }).catchError((onError) {
        emit(const PostInvoiceStatementFailedState());
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetClosingBalanceList>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getClosingBalanceList(ProductSchemaRequset(
        fromTimeStamp: event.fromTimeStamp,
      ))
          .then((value) {
        emit(ClosingBalanceSuccessState(data: value));
        _saveClosingBalanceIntoDatabase(value.data);
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(ClosingBalanceFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  /// DB Insertion
  Future<void> _saveCustomerIntoDatabase(
          List<CustomerDataItemsResponse>? userData) async =>
      await dbModule.dbInstance.customerDao
          .insertAllData(userData ?? [])
          .then((value) async {
        for (int i = 0; i < userData!.length; i++) {
          if (userData[i].customerAddress != null) {
            await dbModule.dbInstance.customerAddressDao
                .insertCustomerAddressData(userData[i].customerAddress!);
          }
        }

        /// updating previous screen.
      });

  Future<void> _saveCustomerTypeIntoDatabase(
          List<CustomerTypeDataResponse>? userData) async =>
      await dbModule.dbInstance.customerTypeDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveStateIntoDatabase(
          List<StateDataItemResponse>? userData) async =>
      await dbModule.dbInstance.stateDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveRouteIntoDatabase(List<RouteItems>? userData) async =>
      await dbModule.dbInstance.routeDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveProductTrendsIntoDatabase(
      List<ProductTrendsItem>? productTrendData) async {
    await dbModule.dbInstance.productTrendsDao
        .insertAllData(productTrendData ?? [])
        .then((value) {
      productTrendData?.forEach((element) async {
        await dbModule.dbInstance.productTrendsLocationDao
            .insertAllData(element.productTrendLocations ?? [])
            .then((value) {});
      });
    });
  }

  Future<void> _saveDistrictIntoDatabase(List<DistrictItems>? userData) async =>
      await dbModule.dbInstance.districtDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveProductIntoDatabase(
      List<ProductListDataItemsResponse>? userData) async {
    if (userData != null && userData.isNotEmpty) {
      await dbModule.dbInstance.productDao
          .insertAllData(userData)
          .then((value) {
        /// updating previous screen.
      }).catchError((onError) {
        print(onError.toString());
      });
    }
  }

  Future<void> _saveDistributionIntoDatabase(
          List<DistributionData>? userData) async =>
      await dbModule.dbInstance.distributionDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveLocationIntoDatabase(
          List<LocationDataItems>? userData) async =>
      await dbModule.dbInstance.locationDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveCountryIntoDatabase(List<CountryData>? userData) async =>
      await dbModule.dbInstance.countryDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveUoMIntoDatabase(List<UOMDataResponse>? userData) async =>
      await dbModule.dbInstance.uomDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveWarehouseIntoDatabase(
          List<WarehouseDataItemsResponse>? userData) async =>
      await dbModule.dbInstance.warehouseDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveVisitPartnersIntoDatabase(
          List<VisitPartnersDataResponse>? userData) async =>
      await dbModule.dbInstance.visitPartnerDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveProductGroupIntoDatabase(
          List<ProductGroupItems>? userData) async =>
      await dbModule.dbInstance.productGroupDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveProductPricingIntoDatabase(
          List<ProductPricingItems>? userData) async =>
      await dbModule.dbInstance.productPricingDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveProductCategoryIntoDatabase(
          List<ProductCategoryListDataItemsResponse>? userData) async =>
      await dbModule.dbInstance.productCategoryDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveSchemeIntoDatabase(
          List<SchemeListDataResponse>? userData) async =>
      await dbModule.dbInstance.schemeDao
          .insertAllData(userData ?? [])
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

  Future<void> _saveProductSchemeIntoDatabase(
          List<ProductSchemaData>? userData) async =>
      await dbModule.dbInstance.productSchemeDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
        print("product schema");
      });

  Future<void> _saveImageFolderIntoDatabase(
          List<ImageFolderDataResponse>? userData) async =>
      await dbModule.dbInstance.imageFolderDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

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

  Future<void> _savecustomercategoryIntoDatabase(
          List<CustomerCategoryDataResponse>? userData) async =>
      await dbModule.dbInstance.customerCategoryDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveCustomerImageIntoDatabase(
          List<CustomerImageItemResponse>? userData) async =>
      await dbModule.dbInstance.customerImageDao
          .insertAllData(userData ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveNoOrderTypeIntoDatabase(
          List<NoOrderTypeData>? noOrderType) async =>
      await dbModule.dbInstance.noOrderTypeDio
          .insertAllData(noOrderType ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveNoOrderIntoDatabase(List<NoOrderRequest>? noOrder) async =>
      await dbModule.dbInstance.noOrderDao
          .insertAllData(noOrder ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveSalesReturnHistoryIntoDatabase(
      List<SalesReturnItem> salesReturnData) async {
    await dbModule.dbInstance.salesReturnDao
        .insertAllData(salesReturnData)
        .then((value) {});
  }

  Future<void> _saveJourneyCycleIntoDatabase(
      List<JourneyCycleData> journeyCycleData) async {
    await dbModule.dbInstance.journeyCycleDao
        .insertAllData(journeyCycleData)
        .then((value) {});
  }

  Future<void> _saveFinancialYearIntoDatabase(
      List<FinancialYearData> financialYearData) async {
    await dbModule.dbInstance.financialYearDao
        .insertAllData(financialYearData)
        .then((value) {});
  }

  Future<void> _saveInvoicesIntoDatabase(
      List<OrderInvoiceMapping> orderInvoiceData) async {
    await dbModule.dbInstance.invoiceMappingDao
        .insertAllData(orderInvoiceData)
        .then((value) {});
  }

  Future<void> _saveInvoiceItemsIntoDatabase(
      List<InvoiceItem> invoiceItems) async {
    await dbModule.dbInstance.invoiceItemDao
        .insertAllData(invoiceItems)
        .then((value) {});
  }

  Future<void> _saveSalesReturnReasonIntoDatabase(
      List<SalesReturnReason> salesReturnReasonData) async {
    await dbModule.dbInstance.salesReturnReasonDao
        .insertAllData(salesReturnReasonData)
        .then((value) {});
  }

  Future<void> _saveLeaveIntoDatabase(List<LeaveItem>? leave) async =>
      await dbModule.dbInstance.leaveDao
          .insertAllData(leave ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveAttendanceIntoDatabase(
          List<AttendanceItem>? attendance) async =>
      await dbModule.dbInstance.attendanceDao
          .insertAllData(attendance ?? [])
          .then((value) {
        attendance?.forEach((element) async {
          await dbModule.dbInstance.attendanceDetailDao
              .insertAllData(element.attendanceDetails ?? [])
              .then((value) {});
        });

        /// updating previous screen.
      });

  Future<void> _saveActivityRegisterTypeIntoDatabase(
          List<ActivityRegisterTypeData>? activityType) async =>
      await dbModule.dbInstance.activityRegisterTypeDao
          .insertAllData(activityType ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveActivityRegisteredIntoDatabase(
          List<ActivityRegisteredItem>? activity) async =>
      await dbModule.dbInstance.activityRegisteredDao
          .insertAllData(activity ?? [])
          .then((value) {
        /// updating previous screen.
      });

  Future<void> _saveInvoiceStatementsIntoDatabase(
          List<InvoiceStatementItem>? data) async =>
      await dbModule.dbInstance.invoiceStatementDao
          .insertInvoiceStatements(data ?? []);

  Future<void> _saveClosingBalanceIntoDatabase(
          List<ClosingBalance>? data) async =>
      await dbModule.dbInstance.closingBalanceDao
          .insertAllData(data ?? []);
}
