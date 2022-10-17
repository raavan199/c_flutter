part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class GetInvoicesFromDB extends AccountEvent {
  const GetInvoicesFromDB(
      {required this.customerId,
      required this.startDate,
      required this.endDate,
      required this.orderId});

  final int customerId;
  final int orderId;
  final String startDate;
  final String endDate;

  @override
  List<Object> get props => [customerId, startDate, endDate,orderId];
}
class GetDataForTopLayoutFromDB extends AccountEvent {
  const GetDataForTopLayoutFromDB(
      {required this.customerId,
        required this.startDate,
        required this.endDate,
      });

  final int customerId;
  final String startDate;
  final String endDate;

  @override
  List<Object> get props => [customerId, startDate,endDate];
}
