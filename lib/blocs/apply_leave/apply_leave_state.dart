part of 'apply_leave_bloc.dart';

abstract class ApplyLeaveState extends Equatable {
  const ApplyLeaveState();

  @override
  List<Object?> get props => [];
}


class ApplyLeaveCallSuccessState extends BaseState {
  const ApplyLeaveCallSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ApplyLeaveCallFailState extends BaseState {
  const ApplyLeaveCallFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

// Leave Type List
class LeaveTypeSuccessState extends BaseState {
  const LeaveTypeSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class LeaveTypeFailState extends BaseState {
  const LeaveTypeFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}