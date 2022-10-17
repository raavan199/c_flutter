part of 'route_bloc.dart';

abstract class RouteState extends Equatable {
  const RouteState();
}

class RouteInitial extends RouteState {
  @override
  List<Object> get props => [];
}

//state states
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


class TotalCustomerCountSuccessState extends BaseState {
  const TotalCustomerCountSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class TotalCustomerCountFailedState extends BaseState {
  const TotalCustomerCountFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetOrderListSuccessState extends BaseState {
  const GetOrderListSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetOrderListFailedState extends BaseState {
  const GetOrderListFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
