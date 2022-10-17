part of 'apply_leave_bloc.dart';

abstract class ApplyLeaveEvent extends Equatable {
  const ApplyLeaveEvent();

  @override
  List<Object?> get props => [];
}


class InsertLeaveIntoDB extends ApplyLeaveEvent {
  InsertLeaveIntoDB({
    required this.leaveData
  });

  LeaveItem leaveData;

  @override
  List<Object> get props => [
        leaveData
      ];
}

class CallApplyLeaveAPI extends ApplyLeaveEvent {
  CallApplyLeaveAPI({
    required this.leaveData
  });

  LeaveItem leaveData;

  @override
  List<Object> get props => [
    leaveData
  ];
}

// To get the Leave Type
class CallLeaveTypeAPI extends ApplyLeaveEvent {
  const CallLeaveTypeAPI({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => 'CallLeaveTypeAPI { fromTimeStamp: $fromTimeStamp }';
}
