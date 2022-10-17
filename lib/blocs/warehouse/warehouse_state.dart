part of 'warehouse_bloc.dart';

abstract class WarehouseState extends Equatable {
  const WarehouseState();
}

class WarehouseInitial extends WarehouseState {
  @override
  List<Object> get props => [];
}

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