part of 'visit_punch_bloc.dart';

abstract class VisitPunchState extends Equatable {
  const VisitPunchState();

  @override
  List<Object?> get props => [];
}

//visit partners states
class VisitPartnersSuccessState extends BaseState {
  const VisitPartnersSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class VisitPartnersFailedState extends BaseState {
  const VisitPartnersFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//visit Punch states
class VisitPunchInDBSuccessState extends BaseState {
  const VisitPunchInDBSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class VisitPunchInDBFailedState extends BaseState {
  const VisitPunchInDBFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//customer states
class CustomerSuccessState extends BaseState {
  const CustomerSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CustomerFailedState extends BaseState {
  const CustomerFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

//customer states
class GetLastVisitByCustomerIdSuccessState extends BaseState {
  const GetLastVisitByCustomerIdSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetLastVisitByCustomerIdFailedState extends BaseState {
  const GetLastVisitByCustomerIdFailedState({this.msg});

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

class GetPunchVisitByCustomerIdSuccessState extends BaseState {
  const GetPunchVisitByCustomerIdSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetPunchVisitByCustomerIdFailedState extends BaseState {
  const GetPunchVisitByCustomerIdFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CustomerAddressSuccessState extends BaseState {
  const CustomerAddressSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CustomerAddressFailedState extends BaseState {
  const CustomerAddressFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class OrderDataSuccessState extends BaseState {
  const OrderDataSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class OrderDataFailedState extends BaseState {
  const OrderDataFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class NoOrderDataSuccessState extends BaseState {
  const NoOrderDataSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class NoOrderDataFailedState extends BaseState {
  const NoOrderDataFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
