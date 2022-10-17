part of 'timeline_bloc.dart';

abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object> get props => [];
}

class CustomerTypeSuccessState extends BaseState {
  const CustomerTypeSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CustomerTypeFailedState extends BaseState {
  const CustomerTypeFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class VisitSuccessState extends BaseState {
  const VisitSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class VisitFailedState extends BaseState {
  const VisitFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
