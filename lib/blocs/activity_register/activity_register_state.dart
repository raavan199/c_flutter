part of 'activity_register_bloc.dart';

abstract class ActivityRegisterState extends Equatable {
  const ActivityRegisterState();

  @override
  List<Object> get props => [];
}

class GetActivityTypesSuccessState extends BaseState {
  const GetActivityTypesSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetActivityTypesFailedState extends BaseState {
  const GetActivityTypesFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class InsertActivitySuccessState extends BaseState {
  const InsertActivitySuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class InsertActivityFailedState extends BaseState {
  const InsertActivityFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncActivitySuccessState extends BaseState {
  const GetUnSyncActivitySuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUnSyncActivityFailedState extends BaseState {
  const GetUnSyncActivityFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class SaveActivityRegisterSuccessState extends BaseState {
  const SaveActivityRegisterSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class SaveActivityRegisterFailedState extends BaseState {
  const SaveActivityRegisterFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteUnSyncActivityFailedState extends BaseState {
  const DeleteUnSyncActivityFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetActivityRegisteredAPISuccessState extends BaseState {
  const GetActivityRegisteredAPISuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetActivityRegisteredAPIFailedState extends BaseState {
  const GetActivityRegisteredAPIFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

