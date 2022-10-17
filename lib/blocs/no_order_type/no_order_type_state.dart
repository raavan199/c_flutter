part of 'no_order_type_bloc.dart';

abstract class NoOrderTypeState extends Equatable {
  const NoOrderTypeState();

  @override
  List<Object?> get props => [];
}

class GetNoOrderTypeSuccessState extends BaseState {
  const GetNoOrderTypeSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetNoOrderTypeFailState extends BaseState {
  const GetNoOrderTypeFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class InsertNoOrderIntoDBSuccessState extends BaseState {
  const InsertNoOrderIntoDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class InsertNoOrderIntoDBFailedState extends BaseState {
  const InsertNoOrderIntoDBFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncNoOrderSuccessState extends BaseState {
  const GetUnSyncNoOrderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUnSyncNoOrderFailedState extends BaseState {
  const GetUnSyncNoOrderFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class NoOrderApiCallSuccessSate extends BaseState {
  const NoOrderApiCallSuccessSate({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class NoOrderApiCallFailedState extends BaseState {
  const NoOrderApiCallFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteUnSyncNoOrderSuccessState extends BaseState {
  const DeleteUnSyncNoOrderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DeleteUnSyncNoOrderFailState extends BaseState {
  const DeleteUnSyncNoOrderFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class NoOrderSuccessState extends BaseState {
  const NoOrderSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class NoOrderFailedState extends BaseState {
  const NoOrderFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

