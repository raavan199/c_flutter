part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object?> get props => [];
}

class GetCustomersBasedOnRoutes extends CustomerEvent {
  const GetCustomersBasedOnRoutes({
    required this.routeId,
  });

  final int routeId;
  @override
  List<Object> get props => [];
}

class GetRoutesCountFromDB extends CustomerEvent {

  @override
  List<Object> get props => [];
}

class GetOrdersMappingFromDB extends CustomerEvent {
  const GetOrdersMappingFromDB({
    required this.routeId,
  });
  final int routeId;
  @override
  List<Object> get props => [];
}


