part of 'modify_outlet_bloc.dart';

@immutable
abstract class ModifyOutletEvent extends Equatable {
  const ModifyOutletEvent();

  @override
  List<Object?> get props => [];
}

class GetCustomerTypeFromDBEvent extends ModifyOutletEvent{

  @override
  List<Object> get props => [];
}


class GetCustomerCategoryFromDBEvent extends ModifyOutletEvent{

  @override
  List<Object> get props => [];
}

class GetSupplierInOutletFromDB extends ModifyOutletEvent {
  @override
  List<Object> get props => [];
}

class GetRouteListFromDB extends ModifyOutletEvent {
  @override
  List<Object> get props => [];
}

class AddOutlet extends ModifyOutletEvent {
  const AddOutlet({
    required this.customerDataItemsResponse
  });

  final CustomerDataItemsResponse customerDataItemsResponse;

  @override
  List<Object> get props => [customerDataItemsResponse];
}

class UpdateCustomerTable extends ModifyOutletEvent {
  const UpdateCustomerTable({
    required this.customerDataItemsResponse,
  });

  final CustomerDataItemsResponse customerDataItemsResponse;

  @override
  List<Object> get props => [customerDataItemsResponse];
}

class UpdateAddressTable extends ModifyOutletEvent {
  const UpdateAddressTable({
    required this.customerAddressResponse,
  });

  final List<CustomerAddressResponse> customerAddressResponse;

  @override
  List<Object> get props => [customerAddressResponse];
}
