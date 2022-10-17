part of 'no_order_type_bloc.dart';

abstract class NoOrderTypeEvent extends Equatable {
  const NoOrderTypeEvent();

  @override
  List<Object?> get props => [];
}

class GetNoOrderTypeFromDB extends NoOrderTypeEvent {
  const GetNoOrderTypeFromDB();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'GetOrderRecordListFromDB {}';
}

class InsertNoOrderIntoDB extends NoOrderTypeEvent {
  InsertNoOrderIntoDB(
      {required this.request});

 NoOrderRequest request;

  @override
  List<Object> get props => [
    request
  ];

}


class GetUnSyncNoOrder extends NoOrderTypeEvent {
  const GetUnSyncNoOrder();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'GetUnSyncNoOrder {}';
}

class NoOrderAPICall extends NoOrderTypeEvent {
   NoOrderAPICall({required this.request,
     });

   final List<NoOrderRequest> request;

  @override
  List<Object> get props => [
    request,
  ];

  @override
  String toString() =>
      'NoOrderAPICall { request: $request}';
}

class DeleteUnSyncNoOrderFromDB extends NoOrderTypeEvent {
  const DeleteUnSyncNoOrderFromDB();

  @override
  List<Object> get props => [];
}

///event to get the lastSync Time of the perticular table
class GetNewNoOrder extends NoOrderTypeEvent {
  const GetNewNoOrder();

  @override
  List<Object> get props => [];
}