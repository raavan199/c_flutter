part of 'visit_punch_bloc.dart';

abstract class VisitPunchEvent extends Equatable {
  const VisitPunchEvent();

  @override
  List<Object?> get props => [];
}

class GetCustomerDetailFromDB extends VisitPunchEvent {
  const GetCustomerDetailFromDB({required this.id});

  final int id;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'GetCustomerDetailFromDB { id: $id}';
}

class GetLastVisitByCustomerIdFromDB extends VisitPunchEvent {
  const GetLastVisitByCustomerIdFromDB({required this.id});

  final int id;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'GetLastVisitByCustomerIdFromDB { id: $id}';
}


class GetPunchVisitByCustomerIdFromDB extends VisitPunchEvent {
  const GetPunchVisitByCustomerIdFromDB({required this.id});

  final int id;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'GetPunchVisitByCustomerIdFromDB { id: $id}';
}

class GetVisitPartnerListFromDB extends VisitPunchEvent {
  @override
  List<Object> get props => [];
}

class InsertVisitDetailIntoDB extends VisitPunchEvent {
  InsertVisitDetailIntoDB({
    required this.visitType,
    required this.startTime,
    required this.customerId,
    required this.makeOwner,
    required this.scopeId,
    required this.userId,
    this.partnerId,
    this.endTime,
  });

  final int visitType;
  final String startTime;
  String? endTime;
  final int customerId;
  int? partnerId;
  final bool makeOwner;
  final int scopeId;
  final int userId;

  @override
  List<Object> get props => [
        visitType,
        startTime,
        customerId,
        partnerId!,
        makeOwner,
    scopeId,
        userId,
        endTime!
      ];

  @override
  String toString() =>
      'InsertVisitDetailIntoDB { visitType: $visitType, punchDateTime: $startTime, customerId: $customerId, partnerId: $partnerId, makeOwner: $makeOwner, scopeId: $scopeId, userId: $userId, endTime: $endTime }';
}

class GetUnSyncVisitPunchFromDB extends VisitPunchEvent {
  const GetUnSyncVisitPunchFromDB();

  @override
  List<Object> get props => [];
}

class VisitPunchAPICall extends VisitPunchEvent {
  const VisitPunchAPICall({required this.request});

  final List<VisitDataItemsResponse> request;

  @override
  List<Object> get props => [request];

  @override
  String toString() => 'VisitPunchAPICall { request: $request }';
}

class DeleteUnSyncVisitFromDB extends VisitPunchEvent {
  const DeleteUnSyncVisitFromDB();

  @override
  List<Object> get props => [];
}


///event to get the lastSync Time of the perticular table
class GetLastTimeStampFromDb extends VisitPunchEvent {
  const GetLastTimeStampFromDb();

  @override
  List<Object> get props => [];
}


class GetVisitDataAPICall extends VisitPunchEvent {
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

class GetCustomerAddressesFromDB extends VisitPunchEvent {
  const GetCustomerAddressesFromDB({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class GetOrderDataFromDB extends VisitPunchEvent {
  const GetOrderDataFromDB({
    required this.orderId,
  });

  final int orderId;

  @override
  List<Object> get props => [orderId];
}

class GetNoOrderDataFromDB extends VisitPunchEvent {
  const GetNoOrderDataFromDB({
    required this.noOrderId,
  });

  final int noOrderId;

  @override
  List<Object> get props => [noOrderId];
}
