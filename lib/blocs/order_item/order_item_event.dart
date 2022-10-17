part of 'order_item_bloc.dart';

@immutable
abstract class OrderItemEvent extends Equatable {
  const OrderItemEvent();

  @override
  List<Object?> get props => [];
}

class GetDistributorName extends OrderItemEvent {
  const GetDistributorName({
    required this.distributorId,
  });

  final int distributorId;

  @override
  List<Object> get props => [distributorId];
}

class GetOrderDataFromDB extends OrderItemEvent {
  const GetOrderDataFromDB({
    required this.orderId,
  });

  final int orderId;

  @override
  List<Object> get props => [orderId];
}
