part of 'outlet_info_bloc.dart';

abstract class OutletInfoEvent extends Equatable {
  const OutletInfoEvent();

  @override
  List<Object?> get props => [];
}

class UpdateVisitPunchIntoDB extends OutletInfoEvent {
  const UpdateVisitPunchIntoDB(
      {required this.visitId,
      required this.endTime,
      required this.isSync,
      required this.userId,
      this.scopeId});

  final int visitId;
  final int? scopeId;
  final String endTime;
  final int isSync;
  final int userId;

  @override
  List<Object> get props => [visitId, endTime,isSync,userId];

}

class GetUnSyncVisitPunchFromDB extends OutletInfoEvent {
  const GetUnSyncVisitPunchFromDB();

  @override
  List<Object> get props => [];
}

class VisitPunchAPICall extends OutletInfoEvent {
  const VisitPunchAPICall({required this.request});

  final List<VisitDataItemsResponse> request;

  @override
  List<Object> get props => [request];

  @override
  String toString() => 'VisitPunchAPICall { request: $request }';
}

class DeleteUnSyncVisitFromDB extends OutletInfoEvent {
  const DeleteUnSyncVisitFromDB();

  @override
  List<Object> get props => [];
}

class GetVisitDataAPICall extends OutletInfoEvent {
  const GetVisitDataAPICall(
      {required this.pageIndex, required this.fromTimeStamp});

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
         GetVisitDataAPICall { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp }''';
}

///event to get the lastSync Time of the perticular table
class GetLastTimeStampFromDb extends OutletInfoEvent {
  const GetLastTimeStampFromDb();

  @override
  List<Object> get props => [];
}

class GetLastOrderByCustomerId extends OutletInfoEvent {
  const GetLastOrderByCustomerId({required this.customerId});

  final int customerId;

  @override
  List<Object> get props => [customerId];

  @override
  String toString() => 'GetLastOrderByCustomerId { customerId: $customerId }';
}
class GetCustomerAddressesFromDB extends OutletInfoEvent {
  const GetCustomerAddressesFromDB({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}