part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object?> get props => [];
}

class GetOrderRecordListFromDB extends OrderHistoryEvent {
  const GetOrderRecordListFromDB({
    required this.customerId,
    required this.startDate,
    required this.endDate,
  });

  final int customerId;
  final String startDate;
  final String endDate;

  @override
  List<Object> get props => [customerId, startDate, endDate];

  @override
  String toString() =>
      'GetOrderRecordListFromDB { customerId: $customerId, startDate: $startDate, endDate: $endDate, }';
}
