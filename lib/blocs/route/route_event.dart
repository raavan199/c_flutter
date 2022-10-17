part of 'route_bloc.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();

  @override
  List<Object?> get props => [];
}

class GetRouteListFromDB extends RouteEvent {
  @override
  List<Object> get props => [];
}

class GetTotalCustomerCountFromDB extends RouteEvent {
  @override
  List<Object> get props => [];
}

class GetOrdersFromDB extends RouteEvent {
  @override
  List<Object> get props => [];
}
