part of 'sync_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object?> get props => [];
}

class CallStateApi extends SyncEvent {
  const CallStateApi({
    required this.pageIndex,
  });

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];

  @override
  String toString() => '''
CallStateApi { pageIndex: $pageIndex }''';
}

class CallCustomerTypeApi extends SyncEvent {
  const CallCustomerTypeApi({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => 'CallCustomerTypeApi { fromTimeStamp: $fromTimeStamp, }';
}

class CallCustomerApi extends SyncEvent {
  const CallCustomerApi({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
CallCustomerApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp, }''';
}

class CallProductListApi extends SyncEvent {
  const CallProductListApi(
      {required this.pageIndex, required this.fromTimeStamp});

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
CallCustomerApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp,  }''';
}

class CallWarehouseApi extends SyncEvent {
  const CallWarehouseApi({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
CallWarehouseApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp}''';
}

class CallVisitPartnersApi extends SyncEvent {
  const CallVisitPartnersApi({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
CallVisitPartnersApi { fromTimeStamp: $fromTimeStamp }''';
}

class CallSchemeListApi extends SyncEvent {
  const CallSchemeListApi({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
CallSchemeListApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp, }''';
}

class CallProductCategoryListApi extends SyncEvent {
  const CallProductCategoryListApi({
    required this.pageIndex,
    this.status,
    this.sortBy,
    this.sortDesc,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final int? status;
  final String? sortBy;
  final bool? sortDesc;
  final String? fromTimeStamp;

  @override
  List<Object> get props =>
      [pageIndex, status!, sortBy!, sortDesc!, fromTimeStamp!];

  @override
  String toString() => '''
CallProductCategoryListApi { pageIndex: $pageIndex, status: $status, sortBy: $sortBy, sortDesc: $sortDesc, fromTimeStamp: $fromTimeStamp, }''';
}

class CallVisitApi extends SyncEvent {
  const CallVisitApi({required this.pageIndex, required this.fromTimeStamp});

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
         CallVisitApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp }''';
}

class ProductTrendsApi extends SyncEvent {
  const ProductTrendsApi(
      {required this.pageIndex, required this.fromTimeStamp});

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
         ProductTrendsApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp }''';
}

///event to get the lastSync Time of the perticular table
class GetLastTimeStampFromDb extends SyncEvent {
  const GetLastTimeStampFromDb(
      {required this.tableName, required this.apiSequence});

  final String tableName;
  final APISequence apiSequence;

  @override
  List<Object> get props => [tableName, apiSequence];

  @override
  String toString() =>
      'GetLastTimeStampFromDb { tableName: $tableName apiSequence: $apiSequence}';
}

///Event for route api request
class CallGetRouteApi extends SyncEvent {
  CallGetRouteApi({required this.pageIndex, required this.fromTimeStamp});

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
         CallGetRouteApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp }''';
}

///Event for district api request
class CallDistrictApiEvent extends SyncEvent {
  const CallDistrictApiEvent({required this.pageIndex});

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];

  @override
  String toString() => '''
         CallDistrictApiEvent { pageIndex: $pageIndex }''';
}

///Event for distribution api request
class CallDistributionApiEvent extends SyncEvent {
  const CallDistributionApiEvent({required this.fromTimeStamp});

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
         CallDistributionApiEvent { fromTimeStamp: $fromTimeStamp,}''';
}

///Event for product group list api request
class CallProductGroupListApiEvent extends SyncEvent {
  CallProductGroupListApiEvent(
      {this.pageIndex,
      this.pageSize,
      this.status,
      this.sortBy,
      this.sortDesc,
      this.fromTimeStamp});

  int? pageIndex;
  int? pageSize;
  int? status;
  String? sortBy;
  bool? sortDesc;
  String? fromTimeStamp;

  @override
  List<Object> get props =>
      [pageIndex!, pageSize!, status!, sortBy!, sortDesc!, fromTimeStamp!];

  @override
  String toString() => '''
         CallProductGroupListApiEvent { pageIndex: $pageIndex,
          pageSize: $pageSize, 
          status: $status, 
          sortBy: $sortBy,
          sortDesc: $sortDesc,
          fromTimeStamp: $fromTimeStamp,}''';
}

///Event for unit of measurement  api request
class CallUOMApiEvent extends SyncEvent {
  CallUOMApiEvent({required this.fromTimeStamp});

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
         CallUOMApiEvent { fromTimeStamp: $fromTimeStamp,}''';
}

///Event for product pricing list  api request
class CallProductPricingListApiEvent extends SyncEvent {
  CallProductPricingListApiEvent({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int? pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex!, fromTimeStamp!];

  @override
  String toString() => '''
         CallProductPricingListApiEvent { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp,}''';
}

///Event for product schema register list  api request
class CallProductSchemaRegisterListApiEvent extends SyncEvent {
  CallProductSchemaRegisterListApiEvent({required this.fromTimeStamp});

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
         CallProductSchemaRegisterListApiEvent { fromTimeStamp: $fromTimeStamp,}''';
}

///Event for country  list  api request
class CallCountryListApiEvent extends SyncEvent {
  CallCountryListApiEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => '''
         CallCountryListApiEvent''';
}

///Event for location  list api request
class CallLocationListApiEvent extends SyncEvent {
  CallLocationListApiEvent(
      {required this.pageIndex, required this.fromTimeStamp});

  int? pageIndex;
  String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex!, fromTimeStamp!];

  @override
  String toString() => '''
         CallLocationListApiEvent{ pageIndex: $pageIndex,
          fromTimeStamp: $fromTimeStamp,}''';
}

///Event for customer category  list api request
class CallCustomerCategoryApiEvent extends SyncEvent {
  CallCustomerCategoryApiEvent({this.fromTimeStamp});

  String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
         CallCustomerCategoryApiEvent{ fromTimeStamp: $fromTimeStamp,}''';
}

class CallImageFolderAPI extends SyncEvent {
  const CallImageFolderAPI({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
CallAlbumFolderAPI { fromTimeStamp: $fromTimeStamp }''';
}

// Order Record List API event
class CallOrderRecordApi extends SyncEvent {
  const CallOrderRecordApi({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
CallOrderRecordApi { fromTimeStamp: $fromTimeStamp }''';
}

// Order Item List API event
class CallOrderItemApi extends SyncEvent {
  const CallOrderItemApi({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
CallOrderRecordApi { fromTimeStamp: $fromTimeStamp }''';
}

// To get the mapping of visit and order
class CallVisitOrderMappingApi extends SyncEvent {
  const CallVisitOrderMappingApi({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
CallVisitOrderMappingApi { fromTimeStamp: $fromTimeStamp }''';
}

class CallCustomerImageApi extends SyncEvent {
  const CallCustomerImageApi({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() =>
      'CallCustomerApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp, }';
}

// To get the No order Type
class CallNoOrderTypeAPI extends SyncEvent {
  const CallNoOrderTypeAPI({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => 'CallNoOrderTypeAPI { fromTimeStamp: $fromTimeStamp }';
}

class LeaveApiCall extends SyncEvent {
  const LeaveApiCall({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];
}

class CallAttendanceAPI extends SyncEvent {
  const CallAttendanceAPI({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];
}

class CallActivityRegisterTypeAPI extends SyncEvent {
  const CallActivityRegisterTypeAPI({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];
}

class CallActivityRegisteredAPI extends SyncEvent {
  const CallActivityRegisteredAPI({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];
}

///
/// Upload APi call Events
///

class GetUnSyncVisitPunchFromDB extends SyncEvent {
  const GetUnSyncVisitPunchFromDB();

  @override
  List<Object> get props => [];
}

class ManageVisitPunchAPICall extends SyncEvent {
  const ManageVisitPunchAPICall({required this.request});

  final List<VisitDataItemsResponse> request;

  @override
  List<Object> get props => [request];

  @override
  String toString() => 'VisitPunchAPICall { request: $request }';
}

class DeleteUnSyncVisitFromDB extends SyncEvent {
  const DeleteUnSyncVisitFromDB();

  @override
  List<Object> get props => [];
}

class GetUnSyncOrderFromDB extends SyncEvent {
  const GetUnSyncOrderFromDB();

  @override
  List<Object> get props => [];
}

class PlaceOrderAPICall extends SyncEvent {
  PlaceOrderAPICall({required this.placeOrderItem, required this.index});

  OrderRecordDataResponse placeOrderItem;
  int index;

  @override
  List<Object> get props => [placeOrderItem, index];
}

class DeleteUnSyncOrder extends SyncEvent {
  const DeleteUnSyncOrder();

  @override
  List<Object> get props => [];
}

class GetUnSyncNoOrder extends SyncEvent {
  const GetUnSyncNoOrder();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetUnSyncNoOrder {}';
}

class NoOrderAPICall extends SyncEvent {
  NoOrderAPICall({
    required this.request,
  });

  final List<NoOrderRequest> request;

  @override
  List<Object> get props => [
        request,
      ];

  @override
  String toString() => 'NoOrderAPICall { request: $request}';
}

class DeleteUnSyncNoOrderFromDB extends SyncEvent {
  const DeleteUnSyncNoOrderFromDB();

  @override
  List<Object> get props => [];
}

class CallNoOrderAPI extends SyncEvent {
  const CallNoOrderAPI({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() =>
      'CallNoOrderAPI { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp, }';
}

class GetSalesReturnHistory extends SyncEvent {
  const GetSalesReturnHistory({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];
}

class GetInvoices extends SyncEvent {
  const GetInvoices({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];
}

class GetSalesReturnReason extends SyncEvent {
  const GetSalesReturnReason({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];
}

class GetJourneyCycleList extends SyncEvent {
  const GetJourneyCycleList({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];
}

class GetFinancialYearList extends SyncEvent {
  const GetFinancialYearList({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];
}

class GetClosingBalanceList extends SyncEvent {
  const GetClosingBalanceList({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];
}

class GetUnSyncSalesReturn extends SyncEvent {
  const GetUnSyncSalesReturn();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetUnSyncNoOrder {}';
}

class GetUnSyncAttendance extends SyncEvent {
  const GetUnSyncAttendance();

  @override
  List<Object> get props => [];
}

class GetUnSyncActivityRegistered extends SyncEvent {
  const GetUnSyncActivityRegistered();

  @override
  List<Object> get props => [];
}

class PostPaymentCollection extends SyncEvent {
  const PostPaymentCollection();

  @override
  List<Object> get props => [];
}

///Event for route api request
class CallGetInvoiceStatementApi extends SyncEvent {
  CallGetInvoiceStatementApi(
      {required this.pageIndex, required this.fromTimeStamp});

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
         CallGetInvoiceStatementApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp }''';
}
