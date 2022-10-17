part of 'select_supplier_bloc.dart';

abstract class SelectSupplierState extends Equatable {
  const SelectSupplierState();
}

class SelectSupplierInitial extends SelectSupplierState {
  @override
  List<Object> get props => [];
}

//supplier states
class SupplierSuccessState extends BaseState {
  const SupplierSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class SupplierFailedState extends BaseState {
  const SupplierFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
