part of 'add_new_order_bloc.dart';

abstract class AddNewOrderState extends Equatable {
  const AddNewOrderState();
}

class AddNewOrderInitial extends AddNewOrderState {
  @override
  List<Object> get props => [];
}

class GroupSuccessState extends BaseState {
  const GroupSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GroupFailedState extends BaseState {
  const GroupFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CategorySuccessState extends BaseState {
  const CategorySuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CategoryFailedState extends BaseState {
  const CategoryFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class UomSuccessState extends BaseState {
  const UomSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class UomFailedState extends BaseState {
  const UomFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class ProductSchemaSuccessState extends BaseState {
  const ProductSchemaSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductSchemaFailedState extends BaseState {
  const ProductSchemaFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class StockSuccessState extends BaseState {
  const StockSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class StockFailedState extends BaseState {
  const StockFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetProductSuccessState extends BaseState {
  const GetProductSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetProductFailedState extends BaseState {
  const GetProductFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
class GetProductPriceSuccessState extends BaseState {
  const GetProductPriceSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetProductPriceFailedState extends BaseState {
  const GetProductPriceFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
class GetFreeProductSuccessState extends BaseState {
  const GetFreeProductSuccessState({this.data,this.uomData});

  final dynamic data;
  final dynamic uomData;

  @override
  List<Object> get props => <Object>[data,uomData];
}

class GetFreeProductFailedState extends BaseState {
  const GetFreeProductFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}