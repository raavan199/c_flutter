part of 'outlet_info_bloc.dart';

abstract class OutletInfoState extends Equatable {
  const OutletInfoState();

  @override
  List<Object?> get props => [];
}


//visit partners states
class UpdateVisitPunchOutDBSuccessState extends BaseState {
  const UpdateVisitPunchOutDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class UpdateVisitPunchOutDBFailedState extends BaseState {
  const UpdateVisitPunchOutDBFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUnSyncVisitPunchSuccessState extends BaseState {
  const GetUnSyncVisitPunchSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUnSyncVisitPunchFailState extends BaseState {
  const GetUnSyncVisitPunchFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class VisitPunchAPICallSuccessState extends BaseState {
  const VisitPunchAPICallSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class VisitPunchAPICallFailState extends BaseState {
  const VisitPunchAPICallFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class DeleteUnSyncVisitSuccessState extends BaseState {
  const DeleteUnSyncVisitSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class DeleteUnSyncVisitFailState extends BaseState {
  const DeleteUnSyncVisitFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetVisitDataAPICallSuccessState extends BaseState {
  const GetVisitDataAPICallSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetVisitDataAPICallFailState extends BaseState {
  const GetVisitDataAPICallFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetLastSyncDateFromDBSuccessState extends BaseState {
  const GetLastSyncDateFromDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetLastSyncDateFromDBFailState extends BaseState {
  const GetLastSyncDateFromDBFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetLastOrderByCustomerIdSuccessState extends BaseState {
  const GetLastOrderByCustomerIdSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetLastOrderByCustomerIdFailState extends BaseState {
  const GetLastOrderByCustomerIdFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetUpdatedCustomerDetailsSuccessState extends BaseState {
  const GetUpdatedCustomerDetailsSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetUpdatedCustomerDetailsFailState extends BaseState {
  const GetUpdatedCustomerDetailsFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}