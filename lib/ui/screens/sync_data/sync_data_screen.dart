import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/sync/sync_bloc.dart';
import '../../../data/models/LatestDate.dart';
import '../../../data/models/district/district_response.dart';
import '../../../data/models/invoice/get_invoice_response.dart';
import '../../../data/models/invoice/invoice_statement_response.dart';
import '../../../data/models/no_order/no_order_response.dart';
import '../../../data/models/product_trends/product_trend_status_item.dart';
import '../../../data/models/route/get_route_by_user_parent.dart';
import '../../../data/models/sync/api_sync.dart';
import '../../../database/db_module.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../services/service_locator.dart';
import '../../../utilities/shadow.dart';
import '../base/base_screen.dart';
import '../dashboard/dashboard_screen.dart';

/// Created by Dev 2136 on 15/12/2021
/// Modified by Dev 2136 on 15/12/2021
/// Purpose : synchronizing data screen to synchronizing all api data
/// and add to server
class SyncDataScreen extends StatefulWidget {
  const SyncDataScreen({Key? key}) : super(key: key);

  @override
  _SyncDataScreenState createState() => _SyncDataScreenState();
}

enum APISequence {
  Routes,
  Customers,
  CustomerType,
  Disctributor,
  Warehouse,
  ProductList,
  UOM,
  ProductGroups,
  ProductCategories,
  ProductPricing, //fromTime stamp missing
  ProductScheems,
  ProductScheemsMapping,
  VisitPartners,
  UserVisitDetails,
  OrderRecord,
  OrderItem,
  VisitOrderMapping,
  ProductTrends,
  CustomerCategory,
  Country,
  State,
  District,
  Location,
  ImageFolder,
  CustomerImage,
  NoOrderType,
  SalesReturnHistory,
  GetInvoices,
  GetSalesReturnReason,
  Leave,
  Attendance,
  ActivityRegistorType,
  ActivityRegistered,
  GetInvoiceStatement,
  NoOrder,
  JourneyCycle,
  FinancialYear,
  ClosingBalance
}

enum PostAPISequence {
  PostUserPunchInOut,
  PostOrder,
  PostNoOrder,
  PostSalesReturn,
  PostAttendance,
  PostActivityRegister,
  PostPaymentCollection
}

class _SyncDataScreenState extends State<SyncDataScreen> with UtilityMixin {
  late SyncBloc _bloc = SyncBloc(locator<DBModule>());

  List<OrderRecordDataResponse> unSyncOrderList = [];
  List<VisitDataItemsResponse> unSyncVisitList = [];
  List<NoOrderRequest> unSyncNoOrderList = [];
  List<AttendanceItem> unSyncAttendance = [];
  List<ActivityRegisteredItem> unSyncActivityRegister = [];

  List<ApiSync> apiList = [
    /*ApiSync(
        apiName: "State", icon: AppAssets.icArrowsRotate, apiCallStatus: false),
    ApiSync(
        apiName: "Route", icon: AppAssets.icArrowsRotate, apiCallStatus: false),
    ApiSync(
        apiName: "Customer",
        icon: AppAssets.icArrowsRotate,
        apiCallStatus: false),*/
  ];

  int i = 0;

  @override
  void initState() {
    super.initState();
  }

  void _callForLastSyncTimeStamp(APISequence apiCall) {
    switch (apiCall) {
      case APISequence.Routes:
        _bloc.add(
            GetLastTimeStampFromDb(tableName: "route", apiSequence: apiCall));
        break;
      case APISequence.Customers:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "customer", apiSequence: apiCall));
        break;
      case APISequence.CustomerType:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "CustomerType", apiSequence: apiCall));
        break;
      case APISequence.Disctributor:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "Distribution", apiSequence: apiCall));
        break;
      case APISequence.Warehouse:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "Warehouse", apiSequence: apiCall));
        break;
      case APISequence.ProductList:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "productList", apiSequence: apiCall));
        break;
      case APISequence.UOM:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "UnitOfMeasure", apiSequence: apiCall));
        break;
      case APISequence.ProductGroups:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "ProductGroup", apiSequence: apiCall));
        break;
      case APISequence.ProductCategories:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "ProductCategory", apiSequence: apiCall));
        break;
      case APISequence.ProductPricing:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "productPricing", apiSequence: apiCall));
        break;
      case APISequence.ProductScheems:
        _bloc.add(
            GetLastTimeStampFromDb(tableName: "Scheme", apiSequence: apiCall));
        break;
      case APISequence.ProductScheemsMapping:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "ProductScheme", apiSequence: apiCall));
        break;
      case APISequence.VisitPartners:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "VisitPartner", apiSequence: apiCall));
        break;
      case APISequence.UserVisitDetails:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "VisitDetail", apiSequence: apiCall));
        break;
      case APISequence.OrderRecord:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "OrderRecord", apiSequence: apiCall));
        break;
      case APISequence.OrderItem:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "OrderItem", apiSequence: apiCall));
        break;
      case APISequence.VisitOrderMapping:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "VisitOrderMapping", apiSequence: apiCall));
        break;
      case APISequence.CustomerCategory:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "CustomerCategory", apiSequence: apiCall));
        break;
      case APISequence.Country:
        _bloc.add(
            GetLastTimeStampFromDb(tableName: "Country", apiSequence: apiCall));
        break;
      case APISequence.State:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "StateData", apiSequence: apiCall));
        break;
      case APISequence.District:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "district", apiSequence: apiCall));
        break;
      case APISequence.Location:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "Location", apiSequence: apiCall));
        break;
      case APISequence.ProductTrends:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "ProductTrends", apiSequence: apiCall));
        break;
      case APISequence.ImageFolder:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "ImageFolder", apiSequence: apiCall));
        break;
      case APISequence.CustomerImage:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "CustomerImage", apiSequence: apiCall));
        break;
      case APISequence.NoOrderType:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "NoOrderType", apiSequence: apiCall));
        break;
      case APISequence.SalesReturnHistory:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "SalesReturn", apiSequence: apiCall));
        break;
      case APISequence.GetInvoices:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "OrderInvoiceMapping", apiSequence: apiCall));
        break;
      case APISequence.GetSalesReturnReason:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "SalesReturnReason", apiSequence: apiCall));
        break;
      case APISequence.Leave:
        _bloc.add(
            GetLastTimeStampFromDb(tableName: "Leave", apiSequence: apiCall));
        break;
      case APISequence.Attendance:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "Attendance", apiSequence: apiCall));
        break;
      case APISequence.ActivityRegistorType:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "ActivityRegisterType", apiSequence: apiCall));
        break;
      case APISequence.ActivityRegistered:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "ActivityRegistered", apiSequence: apiCall));
        break;
      case APISequence.GetInvoiceStatement:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "InvoiceStatement", apiSequence: apiCall));
        break;
      case APISequence.NoOrder:
        _bloc.add(
            GetLastTimeStampFromDb(tableName: "NoOrder", apiSequence: apiCall));
        break;
      case APISequence.JourneyCycle:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "JourneyCycle", apiSequence: apiCall));
        break;
      case APISequence.FinancialYear:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "FinancialYear", apiSequence: apiCall));
        break;
      case APISequence.ClosingBalance:
        _bloc.add(GetLastTimeStampFromDb(
            tableName: "ClosingBalance", apiSequence: apiCall));
        break;
    }
  }

  void _callForAPI(APISequence apiCall, String? syncTimeStamp) {
    switch (apiCall) {
      case APISequence.Routes:
        _bloc.add(CallGetRouteApi(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.Customers:
        _bloc.add(CallCustomerApi(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.CustomerType:
        _bloc.add(CallCustomerTypeApi(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.Disctributor:
        _bloc.add(CallDistributionApiEvent(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.Warehouse:
        _bloc.add(CallWarehouseApi(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ProductList:
        _bloc.add(
            CallProductListApi(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.UOM:
        _bloc.add(CallUOMApiEvent(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ProductGroups:
        _bloc.add(CallProductGroupListApiEvent(
            pageIndex: 1,
            status: 0,
            sortBy: "",
            sortDesc: true,
            fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ProductCategories:
        _bloc.add(CallProductCategoryListApi(
            pageIndex: 1,
            status: 1,
            sortBy: "",
            sortDesc: true,
            fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ProductPricing:
        _bloc.add(CallProductPricingListApiEvent(
            pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ProductScheems:
        _bloc
            .add(CallSchemeListApi(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ProductScheemsMapping:
        _bloc.add(CallProductSchemaRegisterListApiEvent(
            fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.VisitPartners:
        _bloc.add(CallVisitPartnersApi(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.UserVisitDetails:
        _bloc.add(CallVisitApi(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.OrderRecord:
        _bloc.add(CallOrderRecordApi(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.OrderItem:
        _bloc.add(CallOrderItemApi(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.VisitOrderMapping:
        _bloc.add(CallVisitOrderMappingApi(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.CustomerCategory:
        _bloc.add(CallCustomerCategoryApiEvent(
            fromTimeStamp: "2021-11-15T13:11:17.870Z"));
        break;
      case APISequence.Country:
        _bloc.add(CallCountryListApiEvent());
        break;
      case APISequence.State:
        _bloc.add(const CallStateApi(pageIndex: 1));
        break;
      case APISequence.District:
        _bloc.add(const CallDistrictApiEvent(pageIndex: 1));
        break;
      case APISequence.Location:
        _bloc.add(CallLocationListApiEvent(
            pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ProductTrends:
        _bloc.add(ProductTrendsApi(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ImageFolder:
        _bloc.add(CallImageFolderAPI(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.CustomerImage:
        _bloc.add(
            CallCustomerImageApi(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.NoOrderType:
        _bloc.add(CallNoOrderTypeAPI(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.SalesReturnHistory:
        _bloc.add(GetSalesReturnHistory(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.GetInvoices:
        _bloc.add(GetInvoices(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.GetSalesReturnReason:
        _bloc.add(GetSalesReturnReason(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.Leave:
        _bloc.add(LeaveApiCall(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.Attendance:
        _bloc
            .add(CallAttendanceAPI(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ActivityRegistorType:
        _bloc.add(CallActivityRegisterTypeAPI(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ActivityRegistered:
        _bloc.add(CallActivityRegisteredAPI(
            pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.GetInvoiceStatement:
        _bloc.add(CallGetInvoiceStatementApi(
            pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.NoOrder:
        _bloc.add(CallNoOrderAPI(pageIndex: 1, fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.JourneyCycle:
        _bloc.add(GetJourneyCycleList(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.FinancialYear:
        _bloc.add(GetFinancialYearList(fromTimeStamp: syncTimeStamp));
        break;
      case APISequence.ClosingBalance:
        _bloc.add(GetClosingBalanceList(fromTimeStamp: syncTimeStamp));
        break;
    }
  }

  void _callGetUnSyncDataFromDB(PostAPISequence postAPISequence) {
    switch (postAPISequence) {
      case PostAPISequence.PostUserPunchInOut:
        _bloc.add(const GetUnSyncVisitPunchFromDB());
        break;
      case PostAPISequence.PostOrder:
        _bloc.add(const GetUnSyncOrderFromDB());
        break;
      case PostAPISequence.PostNoOrder:
        _bloc.add(const GetUnSyncNoOrder());
        break;
      case PostAPISequence.PostSalesReturn:
        _bloc.add(const GetUnSyncSalesReturn());
        break;
      case PostAPISequence.PostAttendance:
        _bloc.add(const GetUnSyncAttendance());
        break;
      case PostAPISequence.PostActivityRegister:
        _bloc.add(const GetUnSyncActivityRegistered());
        break;
      case PostAPISequence.PostPaymentCollection:
        _bloc.add(const PostPaymentCollection());
        break;
    }
  }

  @override
  Widget build(BuildContext context) => BaseScreen<SyncBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
          _callGetUnSyncDataFromDB(PostAPISequence.PostUserPunchInOut);
          // _callForLastSyncTimeStamp(APISequence.Routes);
        },
        builder: (context, bloc, child) => BlocListener<SyncBloc, BaseState>(
          listener: (context, state) {
            if (state is SuccessState) {
              _callForAPI((state.data as LatestDate).apiSequence,
                  (state.data as LatestDate).latestDate);
            } else if (state is RouteSuccessState) {
              _manageSuccessStateOfRoute(state.data);
            } else if (state is RouteFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.Customers);
            } else if (state is CustomerSuccessState) {
              _manageSuccessStateOfCustomer(state.data);
            } else if (state is CustomerFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.CustomerType);
            } else if (state is CustomerTypeSuccessState) {
              _callForLastSyncTimeStamp(APISequence.Disctributor);
            } else if (state is CustomerTypeFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.Disctributor);
            } else if (state is DistributionSuccessState) {
              _callForLastSyncTimeStamp(APISequence.Warehouse);
            } else if (state is DistributionFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.Warehouse);
            } else if (state is WarehouseSuccessState) {
              _manageSuccessStateOfWarehouse(state.data);
            } else if (state is WarehouseFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.ProductList);
            } else if (state is ProductListSuccessState) {
              _manageSuccessStateOfProductList(state.data);
            } else if (state is ProductListFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.UOM);
            } else if (state is UOMSuccessState) {
              _callForLastSyncTimeStamp(APISequence.ProductGroups);
            } else if (state is UOMFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.ProductGroups);
            } else if (state is ProductGroupListSuccessState) {
              _manageSuccessStateOfProductGroup(state.data);
            } else if (state is ProductGroupListFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.ProductCategories);
            } else if (state is ProductCategoryListSuccessState) {
              _manageSuccessStateOfProductCategory(state.data);
            } else if (state is ProductCategoryListFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.ProductPricing);
            } else if (state is ProductPricingListSuccessState) {
              _manageSuccessStateOfProductPricing(state.data);
            } else if (state is ProductPricingListFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.ProductScheems);
            } else if (state is SchemeListSuccessState) {
              _callForLastSyncTimeStamp(APISequence.ProductScheemsMapping);
            } else if (state is SchemeListFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.ProductScheemsMapping);
            } else if (state is ProductSchemaRegisterListSuccessState) {
              _callForLastSyncTimeStamp(APISequence.VisitPartners);
            } else if (state is ProductSchemaRegisterListFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.VisitPartners);
            } else if (state is VisitPartnersSuccessState) {
              _callForLastSyncTimeStamp(APISequence.OrderRecord);
            } else if (state is VisitPartnersFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.OrderRecord);
            } else if (state is VisitSuccessState) {
              _manageSuccessStateOfVisit(state.data);
            } else if (state is VisitFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callGetUnSyncDataFromDB(PostAPISequence.PostOrder);
            } else if (state is OrderRecordSuccessState) {
              _callForLastSyncTimeStamp(APISequence.OrderItem);
            } else if (state is OrderRecordFailState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.OrderItem);
            } else if (state is OrderItemSuccessState) {
              _callForLastSyncTimeStamp(APISequence.VisitOrderMapping);
            } else if (state is OrderItemFailState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.VisitOrderMapping);
            } else if (state is VisitOrderMappingSuccessState) {
              _callForLastSyncTimeStamp(APISequence.ProductTrends);
            } else if (state is VisitOrderMappingFailState) {
              _callForLastSyncTimeStamp(APISequence.ProductTrends);
            } else if (state is ProductTrendsSuccessState) {
              _manageSuccessStateOfProductTrends(state.data);
            } else if (state is ProductTrendsFailedState) {
              _callForLastSyncTimeStamp(APISequence.CustomerCategory);
            } else if (state is CustomerCategorySuccessState) {
              _callForLastSyncTimeStamp(APISequence.Country);
            } else if (state is CustomerCategoryFailedState) {
              print("CustomerCategory API call fail");
              _callForLastSyncTimeStamp(APISequence.Country);
            } else if (state is CountryListSuccessState) {
              _callForLastSyncTimeStamp(APISequence.State);
            } else if (state is CountryListFailedState) {
              print("state API call fail");
              _callForLastSyncTimeStamp(APISequence.State);
            } else if (state is StateSuccessState) {
              _manageSuccessStateOfState(state.data);
            } else if (state is StateFailedState) {
              print("state API call fail");
              _callForLastSyncTimeStamp(APISequence.District);
            } else if (state is DistrictSuccessState) {
              _manageSuccessStateOfDistrict(state.data);
            } else if (state is DistrictFailedState) {
              _callForLastSyncTimeStamp(APISequence.Location);
              print("District API call fail");
            } else if (state is LocationSuccessState) {
              _manageSuccessStateOfLocation(state.data);
            } else if (state is LocationFailedState) {
              print("Location API call fail");
              _callForLastSyncTimeStamp(APISequence.ImageFolder);
            } else if (state is ImageFolderSuccessState) {
              _callForLastSyncTimeStamp(APISequence.CustomerImage);
            } else if (state is ImageFolderFailedState) {
              showSnackBar(context, state.msg ?? "");
              _callForLastSyncTimeStamp(APISequence.CustomerImage);
            } else if (state is CustomerImageSuccessState) {
              _manageSuccessStateOfCustomerImage(state.data);
            } else if (state is CustomerImageFailState) {
              _callForLastSyncTimeStamp(APISequence.NoOrderType);
            } else if (state is NoOrderTypeSuccessState) {
              _callForLastSyncTimeStamp(APISequence.SalesReturnHistory);
            } else if (state is NoOrderTypeFailState) {
              _callForLastSyncTimeStamp(APISequence.SalesReturnHistory);
            } else if (state is SalesReturnSuccessState) {
              _callForLastSyncTimeStamp(APISequence.GetInvoices);
            } else if (state is SalesReturnFailedState) {
              _callForLastSyncTimeStamp(APISequence.GetInvoices);
            } else if (state is GetInvoiceSuccessState) {
              _manageSuccessStateOfGetInvoice(state.data);
            } else if (state is GetInvoiceFailedState) {
              _callForLastSyncTimeStamp(APISequence.GetSalesReturnReason);
            } else if (state is SalesReturnReasonSuccessState) {
              _callForLastSyncTimeStamp(APISequence.Leave);
            } else if (state is SalesReturnReasonFailedState) {
              _callForLastSyncTimeStamp(APISequence.Leave);
            } else if (state is CallLeaveAPISuccessState) {
              _callForLastSyncTimeStamp(APISequence.Attendance);
            } else if (state is CallLeaveAPIFailState) {
              _callForLastSyncTimeStamp(APISequence.Attendance);
            } else if (state is CallAttendanceAPISuccessState) {
              _manageSuccessStateOfAttendance(state.data);
            } else if (state is CallAttendanceAPIFailState) {
              _callForLastSyncTimeStamp(APISequence.ActivityRegistorType);
            } else if (state is CallActivityRegisterTypeAPISuccessState) {
              _callForLastSyncTimeStamp(APISequence.ActivityRegistered);
            } else if (state is CallActivityRegisterTypeAPIFailState) {
              _callForLastSyncTimeStamp(APISequence.ActivityRegistered);
            } else if (state is CallActivityRegisteredAPISuccessState) {
              _manageSuccessStateOfActivityRegistered(state.data);
            } else if (state is CallActivityRegisteredAPIFailState) {
              _callForLastSyncTimeStamp(APISequence.GetInvoiceStatement);
            } else if (state is InvoiceStatementSuccessState) {
              _manageSuccessStateOfInvoiceStatement(state.data);
            } else if (state is InvoiceStatementFailedState) {
              _callForLastSyncTimeStamp(APISequence.NoOrder);
            } else if (state is NoOrderSuccessState) {
              _manageSuccessStateOfNoOrder(state.data);
            } else if (state is NoOrderFailedState) {
              _callForLastSyncTimeStamp(APISequence.JourneyCycle);
            } else if (state is JourneyCycleSuccessState) {
              _callForLastSyncTimeStamp(APISequence.FinancialYear);
            } else if (state is JourneyCycleFailedState) {
              _callForLastSyncTimeStamp(APISequence.FinancialYear);
            } else if (state is FinancialYearSuccessState) {
              _callForLastSyncTimeStamp(APISequence.ClosingBalance);
            } else if (state is FinancialYearFailedState) {
              _callForLastSyncTimeStamp(APISequence.ClosingBalance);
            } else if (state is ClosingBalanceSuccessState) {
              _redirectToDashboard(context);
            } else if (state is ClosingBalanceFailedState) {
              _redirectToDashboard(context);
            }
            /// upload Post State listener
            /// PostUserPunchInOut
            else if (state is GetUnSyncVisitPunchSuccessState) {
              unSyncVisitList = state.data;
              if (unSyncVisitList.isNotEmpty) {
                for (var i = 0; i < unSyncVisitList.length; i++) {
                  if (unSyncVisitList[i].id! < 0) {
                    unSyncVisitList[i].id = 0;
                  }
                }
                _bloc.add(ManageVisitPunchAPICall(request: state.data));
              } else {
                _callForLastSyncTimeStamp(APISequence.UserVisitDetails);
                // _callGetUnSyncDataFromDB(PostAPISequence.PostOrder);
              }
            } else if (state is GetUnSyncVisitPunchFailState) {
            } else if (state is ManageVisitPunchAPICallSuccessState) {
              print("VISit punch API call Success");
              _bloc.add(const DeleteUnSyncVisitFromDB());
            } else if (state is ManageVisitPunchAPICallFailState) {
              _callGetUnSyncDataFromDB(PostAPISequence.PostOrder);
            } else if (state is DeleteUnSyncVisitSuccessState) {
              _callForLastSyncTimeStamp(APISequence.UserVisitDetails);
              print("VISit punch Database Delete Success");
              // _callGetUnSyncDataFromDB(PostAPISequence.PostOrder);
            } else if (state is DeleteUnSyncVisitFailState) {
              print("VISit punch Database Delete Fail");
            }
            ///PostOrder
            else if (state is GetUnSyncOrderFailedState) {
              print("GetUnSyncOrderFailedState");
            } else if (state is GetUnSyncOrderItemSuccessState) {
              unSyncOrderList = state.data;
              if (unSyncOrderList.isNotEmpty) {
                callPlaceOrderAPI(0);
              } else {
                _callGetUnSyncDataFromDB(PostAPISequence.PostNoOrder);
              }
              print("GetUnSyncOrderItemSuccessState");
            } else if (state is GetUnSyncOrderItemFailedState) {
              print("GetUnSyncOrderItemFailedState");
            } else if (state is PlaceOrderAPICallSuccessState) {
              if (state.index + 1 < unSyncOrderList.length) {
                callPlaceOrderAPI(state.index + 1);
              } else {
                _bloc.add(const DeleteUnSyncOrder());
              }
              print("PlaceOrderAPICallSuccessState");
            } else if (state is PlaceOrderAPICallFailState) {
              print("PlaceOrderAPICallFailState");
              _callGetUnSyncDataFromDB(PostAPISequence.PostNoOrder);
            } else if (state is DeleteUnSyncOrderSuccessState) {
              _callGetUnSyncDataFromDB(PostAPISequence.PostNoOrder);
              print("PlaceOrderAPICallSuccessState");
            } else if (state is DeleteUnSyncOrderFailState) {
              print("PlaceOrderAPICallFailState");
            }
            ///PostNoOrder
            else if (state is GetUnSyncNoOrderSuccessState) {
              print('GetUnSyncNoOrderSuccessState');
              unSyncNoOrderList = state.data;
              if (unSyncNoOrderList.isNotEmpty) {
                for (var i = 0; i < unSyncNoOrderList.length; i++) {
                  if (unSyncNoOrderList[i].id! < 0) {
                    unSyncNoOrderList[i].id = 0;
                  }
                }
                _bloc.add(NoOrderAPICall(request: unSyncNoOrderList));
              } else {
                _callGetUnSyncDataFromDB(PostAPISequence.PostSalesReturn);
              }
            } else if (state is GetUnSyncNoOrderFailedState) {
              print("GetUnSyncNoOrderFailedState");
            } else if (state is NoOrderApiCallSuccessSate) {
              print("NoOrderApiCallSuccessSate");
              _bloc.add(const DeleteUnSyncNoOrderFromDB());
            } else if (state is NoOrderApiCallFailedState) {
              _callGetUnSyncDataFromDB(PostAPISequence.PostSalesReturn);
              print("NoOrderApiCallFailedState");
            } else if (state is DeleteUnSyncNoOrderSuccessState) {
              print("DeleteUnSyncNoOrderSuccessStates");
              _callGetUnSyncDataFromDB(PostAPISequence.PostSalesReturn);
            } else if (state is DeleteUnSyncNoOrderFailState) {
              print("DeleteUnSyncNoOrderFailState");
            }
            ///PostSalesReturn
            else if (state is PostSalesReturnSuccessState) {
              _callGetUnSyncDataFromDB(PostAPISequence.PostAttendance);
            } else if (state is PostSalesReturnFailedState) {
              _callGetUnSyncDataFromDB(PostAPISequence.PostAttendance);
            }
            ///PostAttendance
            else if (state is GetUnSyncAttendanceSuccessState) {
              unSyncAttendance = state.data;
              if (unSyncAttendance.isEmpty) {
                _callGetUnSyncDataFromDB(PostAPISequence.PostActivityRegister);
              } else {
                showCustomFlushBar(
                    context, 'something Went wrong with unsync attendance');
                _callGetUnSyncDataFromDB(PostAPISequence.PostActivityRegister);
              }
            } else if (state is GetUnSyncAttendanceFailedState) {
              _callGetUnSyncDataFromDB(PostAPISequence.PostActivityRegister);
            } else if (state is UploadAttendanceSuccessState) {
              print("UploadAttendanceSuccessState");
              _callGetUnSyncDataFromDB(PostAPISequence.PostActivityRegister);
            } else if (state is UploadAttendanceFailedState) {
              print("UploadAttendanceFailedState");
              _callGetUnSyncDataFromDB(PostAPISequence.PostActivityRegister);
            }
            ///PostActivityRegister
            else if (state is GetUnSyncActivityRegisterSuccessState) {
              unSyncActivityRegister = state.data;
              if (unSyncActivityRegister.isEmpty) {
                _callGetUnSyncDataFromDB(PostAPISequence.PostPaymentCollection);
              } else {
                showCustomFlushBar(context,
                    'something Went wrong with unsync activity register');
                _callGetUnSyncDataFromDB(PostAPISequence.PostPaymentCollection);
              }
            } else if (state is GetUnSyncActivityRegisterFailedState) {
              _callGetUnSyncDataFromDB(PostAPISequence.PostPaymentCollection);
            } else if (state is UploadActivityRegisterSuccessState) {
              print("UploadAttendanceSuccessState");
              _callGetUnSyncDataFromDB(PostAPISequence.PostPaymentCollection);
            } else if (state is UploadActivityRegisterFailedState) {
              print("UploadAttendanceFailedState");
              _callGetUnSyncDataFromDB(PostAPISequence.PostPaymentCollection);
            }
            /// Post Payment Collection Statement
            else if (state is PostInvoiceStatementSuccessState) {
              _callForLastSyncTimeStamp(APISequence.Routes);
            } else if (state is PostInvoiceStatementFailedState) {
              _callForLastSyncTimeStamp(APISequence.Routes);
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.lblSynchronizingData.toUpperCase(),
            ),
            drawer: const AppDrawer(
              selectedIndex: 3,
            ),
            body: CommonContainer(
              showInternetAlert: true,
              //child: _buildSyncDataView(),
              child: _tempView(),
            ),
          ),
        ),
      );

  Widget _tempView() => Expanded(
    child: Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 70),
      padding: const EdgeInsets.all(AppStyles.pageSideMargin),
      child: const Center(
        child: Text('Syncing data'),
      ),
    ),
  );

  Widget _buildSyncDataView() => Container(
        margin: const EdgeInsets.only(top: 70),
        padding: const EdgeInsets.all(AppStyles.pageSideMargin),
        child: ListView.separated(
          itemCount: apiList.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [Shadows.greyShadow],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  apiList[index].apiName,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                SvgPicture.asset((apiList[index].apiCallStatus == true)
                    ? AppAssets.icCircleCheck
                    : AppAssets.icArrowsRotate)
              ],
            ),
          ),
        ),
      );

  //////////////////////////////start///////////////////////////////////////
  //manage methods for the success states

  ///for route
  void _manageSuccessStateOfRoute(GetRouteByUserParent _getRouteByUserParent) {
    if (_getRouteByUserParent.routeData!.hasNextPage == true) {
      _bloc.add(CallGetRouteApi(
          pageIndex: _getRouteByUserParent.routeData!.pageIndex! + 1,
          fromTimeStamp: _getRouteByUserParent.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(APISequence.Customers);
    }
  }

  ///for customer
  void _manageSuccessStateOfCustomer(CustomerResponse _customerResponse) {
    if (_customerResponse.data!.hasNextPage == true) {
      _bloc.add(CallCustomerApi(
          pageIndex: _customerResponse.data!.pageIndex! + 1,
          fromTimeStamp: _customerResponse.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(APISequence.CustomerType);
    }
  }

  /// for Warehouse
  void _manageSuccessStateOfWarehouse(WarehouseResponse _warehouseResponse) {
    if (_warehouseResponse.data!.hasNextPage == true) {
      _bloc.add(CallWarehouseApi(
          pageIndex: _warehouseResponse.data!.pageIndex! + 1,
          fromTimeStamp: _warehouseResponse.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(APISequence.ProductList);
    }
  }

  /// for Product List
  void _manageSuccessStateOfProductList(
      ProductListResponse _productListResponse) {
    if (_productListResponse.data!.hasNextPage == true) {
      _bloc.add(CallProductListApi(
          pageIndex: _productListResponse.data!.pageIndex! + 1,
          fromTimeStamp: _productListResponse.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(APISequence.UOM);
    }
  }

  /// for Product Group
  void _manageSuccessStateOfProductGroup(
      ProductGroupResponse _productGroupResponse) {
    if (_productGroupResponse.data!.hasNextPage == true) {
      _bloc.add(CallProductGroupListApiEvent(
          pageIndex: _productGroupResponse.data!.pageIndex! + 1,
          fromTimeStamp: _productGroupResponse.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(APISequence.ProductCategories);
    }
  }

  /// for Product Category
  void _manageSuccessStateOfProductCategory(
      ProductCategoryListResponse _productCategoryResponse) {
    if (_productCategoryResponse.data!.hasNextPage == true) {
      _bloc.add(CallProductCategoryListApi(
          pageIndex: _productCategoryResponse.data!.pageIndex! + 1,
          fromTimeStamp: _productCategoryResponse.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(
        APISequence.ProductPricing,
      );
    }
  }

  /// for Product Category
  void _manageSuccessStateOfProductPricing(
      ProductPricingResponse _productPricingResponse) {
    if (_productPricingResponse.data!.hasNextPage == true) {
      _bloc.add(CallProductPricingListApiEvent(
          pageIndex: _productPricingResponse.data!.pageIndex! + 1,
          fromTimeStamp: _productPricingResponse.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(APISequence.ProductScheems);
    }
  }

  /// for Product Category
  void _manageSuccessStateOfVisit(VisitResponse _visitResponse) {
    if (_visitResponse.data.hasNextPage == true) {
      _bloc.add(CallVisitApi(
          pageIndex: _visitResponse.data.pageIndex! + 1,
          fromTimeStamp: _visitResponse.lastSyncTimeStamp));
    } else {
      _callGetUnSyncDataFromDB(PostAPISequence.PostOrder);
    }
  }

  ///for route
  void _manageSuccessStateOfProductTrends(
      ProductTrendStatusItem _baseResponse) {
    if (_baseResponse.data.hasNextPage == true) {
      _bloc.add(ProductTrendsApi(
          pageIndex: _baseResponse.data.pageIndex! + 1,
          fromTimeStamp: _baseResponse.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(APISequence.CustomerCategory);
    }
  }

  ///for state
  void _manageSuccessStateOfState(StateResponse _stateResponse) {
    if (_stateResponse.data!.hasNextPage == true) {
      _bloc.add(CallStateApi(pageIndex: _stateResponse.data!.pageIndex + 1));
    } else {
      _callForLastSyncTimeStamp(APISequence.District);
    }
  }

  ///for district
  void _manageSuccessStateOfDistrict(DistrictResponse _districtResponse) {
    if (_districtResponse.routeData!.hasNextPage == true) {
      print(
          'district API index ${_districtResponse.routeData!.pageIndex! + 1}');
      _bloc.add(CallDistrictApiEvent(
        pageIndex: _districtResponse.routeData!.pageIndex! + 1,
      ));
    } else {
      _callForLastSyncTimeStamp(APISequence.Location);
    }
  }

  ///for location
  void _manageSuccessStateOfLocation(LocationResponse _locationResponse) {
    if (_locationResponse.data!.hasNextPage == true) {
      _bloc.add(CallLocationListApiEvent(
        pageIndex: _locationResponse.data!.pageIndex! + 1,
        fromTimeStamp: _locationResponse.lastSyncTimeStamp,
      ));
    } else {
      _callForLastSyncTimeStamp(APISequence.ImageFolder);
    }
  }

  /// for Customer Image
  void _manageSuccessStateOfCustomerImage(
      CustomerImageResponse _customerImageResponse) {
    if (_customerImageResponse.data!.hasNextPage == true) {
      _bloc.add(CallCustomerImageApi(
          pageIndex: _customerImageResponse.data!.pageIndex! + 1,
          fromTimeStamp: _customerImageResponse.lastSyncTimeStamp));
    } else {
      _callForLastSyncTimeStamp(APISequence.NoOrderType);
    }
  }

  ///for GetInvoice
  void _manageSuccessStateOfGetInvoice(GetInvoiceResponse _getInvoiceResponse) {
    if (_getInvoiceResponse.data!.hasNextPage == true) {
      print('GetInvoice API index ${_getInvoiceResponse.data!.pageIndex! + 1}');
      _bloc.add(GetInvoices(
        fromTimeStamp: _getInvoiceResponse.lastSyncTimeStamp,
        pageIndex: _getInvoiceResponse.data!.pageIndex! + 1,
      ));
    } else {
      _callForLastSyncTimeStamp(APISequence.GetSalesReturnReason);
    }
  }

  /// for Attendance
  void _manageSuccessStateOfAttendance(AttendanceResponse _attendanceResponse) {
    if (_attendanceResponse.data!.hasNextPage == true) {
      _bloc.add(CallAttendanceAPI(
        pageIndex: _attendanceResponse.data!.pageIndex! + 1,
        fromTimeStamp: _attendanceResponse.lastSyncTimeStamp,
      ));
    } else {
      _callForLastSyncTimeStamp(APISequence.ActivityRegistorType);
    }
  }

  /// for activity register List
  void _manageSuccessStateOfActivityRegistered(
      ActivityRegisteredResponse _activityResponse) {
    if (_activityResponse.data!.hasNextPage == true) {
      _bloc.add(CallActivityRegisteredAPI(
        pageIndex: _activityResponse.data!.pageIndex! + 1,
        fromTimeStamp: _activityResponse.lastSyncTimeStamp,
      ));
    } else {
      _callForLastSyncTimeStamp(APISequence.GetInvoiceStatement);
    }
  }

  ///for GetInvoiceStatement
  void _manageSuccessStateOfInvoiceStatement(
      InvoiceStatementResponse _invoiceStatementResponse) {
    if (_invoiceStatementResponse.data!.hasNextPage == true) {
      print(
          'GetInvoice API index ${_invoiceStatementResponse.data!.pageIndex! + 1}');
      _bloc.add(CallGetInvoiceStatementApi(
        fromTimeStamp: _invoiceStatementResponse.lastSyncTimeStamp,
        pageIndex: _invoiceStatementResponse.data!.pageIndex! + 1,
      ));
    } else {
      _callForLastSyncTimeStamp(APISequence.NoOrder);
    }
  }

  ///for no order
  void _manageSuccessStateOfNoOrder(NoOrderResponse noOrderResponse) {
    if (noOrderResponse.data!.hasNextPage == true) {
      _bloc.add(CallNoOrderAPI(
        pageIndex: noOrderResponse.data!.pageIndex! + 1,
        fromTimeStamp: noOrderResponse.lastSyncTimeStamp,
      ));
    } else {
      _callForLastSyncTimeStamp(APISequence.JourneyCycle);
    }
  }

  //////////////////////////////end/////////////////////////////////////////
  void _redirectToDashboard(BuildContext context) {
    clearStackAndAddScreen(context, const DashBoardScreen());
  }

  void callPlaceOrderAPI(int index) {
    _bloc.add(PlaceOrderAPICall(
        placeOrderItem: unSyncOrderList[index], index: index));
  }
}
