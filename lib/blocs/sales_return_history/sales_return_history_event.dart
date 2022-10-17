part of 'sales_return_history_bloc.dart';

@immutable
abstract class SalesReturnHistoryEvent extends Equatable{
  const SalesReturnHistoryEvent();

  @override
  List<Object?> get props => [];
}

class GetSalesReturnHistory extends SalesReturnHistoryEvent {
  const GetSalesReturnHistory({required this.customerId,
    required this.startDate,
    required this.endDate});
  final int customerId;
  final String startDate;
  final String endDate;
  @override
  List<Object> get props => [customerId,startDate,endDate];
}

class GetSalesAdjustment extends SalesReturnHistoryEvent {
  const GetSalesAdjustment({required this.customerId,
    required this.startDate,
    required this.endDate});
  final int customerId;
  final String startDate;
  final String endDate;
  @override
  List<Object> get props => [customerId,startDate,endDate];
}
