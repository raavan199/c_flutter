part of 'leave_bloc.dart';

abstract class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object?> get props => [];
}

class GetLeaveTypeSuccessState extends BaseState {
  const GetLeaveTypeSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetLeaveTypeFailState extends BaseState {
  const GetLeaveTypeFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CallLeaveSuccessState extends BaseState {
  const CallLeaveSuccessState({this.data,this.leave});

  final dynamic data;
  final dynamic leave;

  @override
  List<Object> get props => <Object>[data];
}

class CallLeaveFailState extends BaseState {
  const CallLeaveFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class ManageLeaveCallSuccessState extends BaseState {
  const ManageLeaveCallSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class ManageLeaveCallFailState extends BaseState {
  const ManageLeaveCallFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}


