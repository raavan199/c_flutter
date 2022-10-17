part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
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

class StockSuccessState extends BaseState {
  const StockSuccessState({this.data, required this.productId});

  final dynamic data;
  final int productId;

  @override
  List<Object> get props => <Object>[data, productId];
}

class StockFailedState extends BaseState {
  const StockFailedState({this.msg});

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

class DeleteCartItemsSuccessState extends BaseState {
  const DeleteCartItemsSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DeleteCartItemsFailedState extends BaseState {
  const DeleteCartItemsFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class ProductListFromCartSuccessState extends BaseState {
  const ProductListFromCartSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ProductListFromCartFailedState extends BaseState {
  const ProductListFromCartFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
