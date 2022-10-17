part of 'sync_bloc.dart';

abstract class SyncState extends Equatable {
  const SyncState();
}

class SyncInitial extends SyncState {
  @override
  List<Object> get props => [];
}

//state states
class StateSuccessState extends BaseState {
  const StateSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class StateFailedState extends BaseState {
  const StateFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//customer type states
class CustomerTypeSuccessState extends BaseState {
  const CustomerTypeSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CustomerTypeFailedState extends BaseState {
  const CustomerTypeFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//customer states
class CustomerSuccessState extends BaseState {
  const CustomerSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CustomerFailedState extends BaseState {
  const CustomerFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//product list states
class ProductListSuccessState extends BaseState {
  const ProductListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductListFailedState extends BaseState {
  const ProductListFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//warehouse states
class WarehouseSuccessState extends BaseState {
  const WarehouseSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class WarehouseFailedState extends BaseState {
  const WarehouseFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//visit partners states
class VisitPartnersSuccessState extends BaseState {
  const VisitPartnersSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class VisitPartnersFailedState extends BaseState {
  const VisitPartnersFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class SchemeListSuccessState extends BaseState {
  const SchemeListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class SchemeListFailedState extends BaseState {
  const SchemeListFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class ProductCategoryListSuccessState extends BaseState {
  const ProductCategoryListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductCategoryListFailedState extends BaseState {
  const ProductCategoryListFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class VisitSuccessState extends BaseState {
  const VisitSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class VisitFailedState extends BaseState {
  const VisitFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class RouteSuccessState extends BaseState {
  const RouteSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class RouteFailedState extends BaseState {
  const RouteFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

/// district state
class DistrictSuccessState extends BaseState {
  const DistrictSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DistrictFailedState extends BaseState {
  const DistrictFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///product group list state
class ProductGroupListSuccessState extends BaseState {
  ProductGroupListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductGroupListFailedState extends BaseState {
  const ProductGroupListFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///distribution state
class DistributionSuccessState extends BaseState {
  DistributionSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DistributionFailedState extends BaseState {
  const DistributionFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///unit of measurement state
class UOMSuccessState extends BaseState {
  UOMSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class UOMFailedState extends BaseState {
  const UOMFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///product pricing list state
class ProductPricingListSuccessState extends BaseState {
  ProductPricingListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductPricingListFailedState extends BaseState {
  const ProductPricingListFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///product schema register list state
class ProductSchemaRegisterListSuccessState extends BaseState {
  ProductSchemaRegisterListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductSchemaRegisterListFailedState extends BaseState {
  const ProductSchemaRegisterListFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///country list state
class CountryListSuccessState extends BaseState {
  CountryListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CountryListFailedState extends BaseState {
  const CountryListFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///location list state
class LocationSuccessState extends BaseState {
  LocationSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class LocationFailedState extends BaseState {
  const LocationFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///customer category list state
class CustomerCategorySuccessState extends BaseState {
  const CustomerCategorySuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CustomerCategoryFailedState extends BaseState {
  const CustomerCategoryFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//Image Folder State
class ImageFolderSuccessState extends BaseState {
  const ImageFolderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ImageFolderFailedState extends BaseState {
  const ImageFolderFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

// Order record List
class OrderRecordSuccessState extends BaseState {
  const OrderRecordSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class OrderRecordFailState extends BaseState {
  const OrderRecordFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

// Order Item List
class OrderItemSuccessState extends BaseState {
  const OrderItemSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class OrderItemFailState extends BaseState {
  const OrderItemFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class VisitOrderMappingSuccessState extends BaseState {
  const VisitOrderMappingSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class VisitOrderMappingFailState extends BaseState {
  const VisitOrderMappingFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CustomerImageSuccessState extends BaseState {
  const CustomerImageSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CustomerImageFailState extends BaseState {
  const CustomerImageFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncVisitPunchSuccessState extends BaseState {
  const GetUnSyncVisitPunchSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUnSyncVisitPunchFailState extends BaseState {
  const GetUnSyncVisitPunchFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class ManageVisitPunchAPICallSuccessState extends BaseState {
  const ManageVisitPunchAPICallSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ManageVisitPunchAPICallFailState extends BaseState {
  const ManageVisitPunchAPICallFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteUnSyncVisitSuccessState extends BaseState {
  const DeleteUnSyncVisitSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DeleteUnSyncVisitFailState extends BaseState {
  const DeleteUnSyncVisitFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

// No Order Type List
class NoOrderTypeSuccessState extends BaseState {
  const NoOrderTypeSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class NoOrderTypeFailState extends BaseState {
  const NoOrderTypeFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class NoOrderSuccessState extends BaseState {
  const NoOrderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class NoOrderFailedState extends BaseState {
  const NoOrderFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class ProductTrendsSuccessState extends BaseState {
  const ProductTrendsSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductTrendsFailedState extends BaseState {
  const ProductTrendsFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CallLeaveAPISuccessState extends BaseState {
  const CallLeaveAPISuccessState({this.data, this.leave});

  final dynamic data;
  final dynamic leave;

  @override
  List<Object> get props => <Object>[data, leave];
}

class CallLeaveAPIFailState extends BaseState {
  const CallLeaveAPIFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CallAttendanceAPISuccessState extends BaseState {
  const CallAttendanceAPISuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CallAttendanceAPIFailState extends BaseState {
  const CallAttendanceAPIFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CallActivityRegisterTypeAPISuccessState extends BaseState {
  const CallActivityRegisterTypeAPISuccessState({this.data, this.leave});

  final dynamic data;
  final dynamic leave;

  @override
  List<Object> get props => <Object>[data, leave];
}

class CallActivityRegisterTypeAPIFailState extends BaseState {
  const CallActivityRegisterTypeAPIFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CallActivityRegisteredAPISuccessState extends BaseState {
  const CallActivityRegisteredAPISuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CallActivityRegisteredAPIFailState extends BaseState {
  const CallActivityRegisteredAPIFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncOrderFailedState extends BaseState {
  const GetUnSyncOrderFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncOrderItemSuccessState extends BaseState {
  const GetUnSyncOrderItemSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUnSyncOrderItemFailedState extends BaseState {
  const GetUnSyncOrderItemFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class PlaceOrderAPICallSuccessState extends BaseState {
  const PlaceOrderAPICallSuccessState({this.data,this.index});

  final dynamic data;
  final dynamic index;

  @override
  List<Object> get props => <Object>[data,index];
}

class PlaceOrderAPICallFailState extends BaseState {
  const PlaceOrderAPICallFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteUnSyncOrderSuccessState extends BaseState {
  const DeleteUnSyncOrderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DeleteUnSyncOrderFailState extends BaseState {
  const DeleteUnSyncOrderFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncNoOrderSuccessState extends BaseState {
  const GetUnSyncNoOrderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUnSyncNoOrderFailedState extends BaseState {
  const GetUnSyncNoOrderFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class NoOrderApiCallSuccessSate extends BaseState {
  const NoOrderApiCallSuccessSate({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class NoOrderApiCallFailedState extends BaseState {
  const NoOrderApiCallFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteUnSyncNoOrderSuccessState extends BaseState {
  const DeleteUnSyncNoOrderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DeleteUnSyncNoOrderFailState extends BaseState {
  const DeleteUnSyncNoOrderFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncAttendanceSuccessState extends BaseState {
  const GetUnSyncAttendanceSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUnSyncAttendanceFailedState extends BaseState {
  const GetUnSyncAttendanceFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class UploadAttendanceSuccessState extends BaseState {
  const UploadAttendanceSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class UploadAttendanceFailedState extends BaseState {
  const UploadAttendanceFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class UploadActivityRegisterSuccessState extends BaseState {
  const UploadActivityRegisterSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class UploadActivityRegisterFailedState extends BaseState {
  const UploadActivityRegisterFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncActivityRegisterSuccessState extends BaseState {
  const GetUnSyncActivityRegisterSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUnSyncActivityRegisterFailedState extends BaseState {
  const GetUnSyncActivityRegisterFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class SalesReturnSuccessState extends BaseState {
  const SalesReturnSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class SalesReturnFailedState extends BaseState {
  const SalesReturnFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetInvoiceSuccessState extends BaseState {
  const GetInvoiceSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetInvoiceFailedState extends BaseState {
  const GetInvoiceFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class SalesReturnReasonSuccessState extends BaseState {
  const SalesReturnReasonSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class SalesReturnReasonFailedState extends BaseState {
  const SalesReturnReasonFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class PostSalesReturnSuccessState extends BaseState {
  const PostSalesReturnSuccessState();

  @override
  List<Object> get props => <Object>[];
}

class PostSalesReturnFailedState extends BaseState {
  const PostSalesReturnFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class JourneyCycleSuccessState extends BaseState {
  const JourneyCycleSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class JourneyCycleFailedState extends BaseState {
  const JourneyCycleFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class FinancialYearSuccessState extends BaseState {
  const FinancialYearSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class FinancialYearFailedState extends BaseState {
  const FinancialYearFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///product pricing list state
class InvoiceStatementSuccessState extends BaseState {
  InvoiceStatementSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class InvoiceStatementFailedState extends BaseState {
  const InvoiceStatementFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

///Post invoice Statement list state
class PostInvoiceStatementSuccessState extends BaseState {
  PostInvoiceStatementSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class PostInvoiceStatementFailedState extends BaseState {
  const PostInvoiceStatementFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}


class ClosingBalanceSuccessState extends BaseState {
  const ClosingBalanceSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ClosingBalanceFailedState extends BaseState {
  const ClosingBalanceFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
