part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object?> get props => [];
}

class CallLeaveApi extends LeaveEvent {
  const CallLeaveApi({
    required this.pageIndex,
    required this.fromTimeStamp,
  });

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];
}

class ManageLeaveAPiCall extends LeaveEvent {
  const ManageLeaveAPiCall({required this.leaveData});

  final LeaveItem leaveData;

  @override
  List<Object> get props => [leaveData];
}
