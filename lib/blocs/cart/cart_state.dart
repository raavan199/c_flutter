part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

//state states
class GetProductFromCartSuccessState extends BaseState {
  const GetProductFromCartSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetProductFromCartFailedState extends BaseState {
  const GetProductFromCartFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteProductFromCartSuccessState extends BaseState {
  const DeleteProductFromCartSuccessState({
    required this.index,
    this.data,
  });

  final dynamic data;
  final int index;

  @override
  List<Object> get props => <Object>[data];
}

class DeleteProductFromCartFailedState extends BaseState {
  const DeleteProductFromCartFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class UomCartSuccessState extends BaseState {
  const UomCartSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class UomCartFailedState extends BaseState {
  const UomCartFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteAllDataFromCartSuccessState extends BaseState {
  const DeleteAllDataFromCartSuccessState({
    this.data,
  });

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DeleteAllDataFromCartFailedState extends BaseState {
  const DeleteAllDataFromCartFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class InsertOrderRecordIntoDBSuccessState extends BaseState {
  const InsertOrderRecordIntoDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class InsertOrderRecordIntoDBFailedState extends BaseState {
  const InsertOrderRecordIntoDBFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class SaveOrderItemIntoDBSuccessState extends BaseState {
  const SaveOrderItemIntoDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class SaveOrderItemIntoDBFailedState extends BaseState {
  const SaveOrderItemIntoDBFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncOrderSuccessState extends BaseState {
  const GetUnSyncOrderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
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

class GetLastSyncDateFromDBSuccessState extends BaseState {
  const GetLastSyncDateFromDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetLastSyncDateFromDBFailState extends BaseState {
  const GetLastSyncDateFromDBFailState({this.msg});

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


// Order Item List
class GetSchemeSuccessState extends BaseState {
  const GetSchemeSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetSchemeFailState extends BaseState {
  const GetSchemeFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

// Order Item List
class GetFreeProductDetailsSuccessState extends BaseState {
  const GetFreeProductDetailsSuccessState({this.data,this.freeProduct});

  final dynamic data;
  final dynamic freeProduct;

  @override
  List<Object> get props => <Object>[data,freeProduct];
}

class GetFreeProductDetailsFailState extends BaseState {
  const GetFreeProductDetailsFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetVisitOrderMappingSuccessState extends BaseState {
  const GetVisitOrderMappingSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetVisitOrderMappingFailState extends BaseState {
  const GetVisitOrderMappingFailState({this.msg});

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

