part of 'activity_history_bloc.dart';

abstract class ActivityHistoryState extends Equatable {
  const ActivityHistoryState();
}

class ActivityHistoryInitial extends ActivityHistoryState {
  @override
  List<Object> get props => [];
}

class GetActivityHistorySuccessState extends BaseState {
  const GetActivityHistorySuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetActivityHistoryFailedState extends BaseState {
  const GetActivityHistoryFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteActivityAPISuccessState extends BaseState {
  const DeleteActivityAPISuccessState({required this.id});

  final int id;

  @override
  List<Object> get props => <Object>[id];
}

class DeleteActivityAPIFailedState extends BaseState {
  const DeleteActivityAPIFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteActivityByIdSuccessState extends BaseState {
  const DeleteActivityByIdSuccessState({required this.id});

  final int id;

  @override
  List<Object> get props => <Object>[id];
}

class DeleteActivityByIdFailedState extends BaseState {
  const DeleteActivityByIdFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}