part of 'modify_outlet_bloc.dart';

@immutable
abstract class ModifyOutletState extends Equatable{
  const ModifyOutletState();

  @override
  List<Object?> get props => [];
}

class GetCustomerTypeFromDBSuccessState extends BaseState{
  const GetCustomerTypeFromDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}


class GetCustomerTypeFromDBFailedState extends BaseState{

  const GetCustomerTypeFromDBFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props =>[msg!];
}

class GetCustomerCategoryFromDBSuccessState extends BaseState{
  const GetCustomerCategoryFromDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}


class GetCustomerCategoryFromDBFailedState extends BaseState{

  const GetCustomerCategoryFromDBFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props =>[msg!];
}

class SupplierInOutletSuccessState extends BaseState {
  const SupplierInOutletSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class SupplierInOutletFailedState extends BaseState {
  const SupplierInOutletFailedState({this.msg});

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

class UpdateCustomerTableSuccessState extends BaseState {
  const UpdateCustomerTableSuccessState();
  @override
  List<Object> get props => <Object>[];
}

class UpdateCustomerTableFailedState extends BaseState {
  const UpdateCustomerTableFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}


