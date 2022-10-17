part of 'add_sales_return_bloc.dart';

abstract class AddSalesReturnState extends Equatable {
  const AddSalesReturnState();
}

class AddSalesReturnInitial extends AddSalesReturnState {
  @override
  List<Object> get props => [];
}
class ProductSuccessState extends BaseState {
  const ProductSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductFailedState extends BaseState {
  const ProductFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetReasonSuccessState extends BaseState {
  const GetReasonSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetReasonFailedState extends BaseState {
  const GetReasonFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetDistributorAndWarehouseSuccessState extends BaseState {
  const GetDistributorAndWarehouseSuccessState({this.distributorData,this.warehouseData});

  final dynamic distributorData;
  final dynamic warehouseData;

  @override
  List<Object> get props => <Object>[distributorData,warehouseData];
}

class GetDistributorAndWarehouseFailedState extends BaseState {
  const GetDistributorAndWarehouseFailedState({this.msg});

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

class AddSalesReturnSuccessState extends BaseState {
  const AddSalesReturnSuccessState();


  @override
  List<Object> get props => <Object>[];
}

class AddSalesReturnFailedState extends BaseState {
  const AddSalesReturnFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

